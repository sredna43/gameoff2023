extends Node2D

const levels = {
	0: "res://scenes/levels/level_0.tscn",
	1: "res://scenes/levels/level_1.tscn"
}

@onready var animation_player = $AnimationPlayer
@onready var blackout = $Blackout
@onready var main_menu = $MainMenu
@onready var options_menu = $OptionsMenu
@onready var pause_menu = $PauseMenu

var current_level: Level
var next_level: Level

var loading_status: int
var progress: Array[float]

var load_path: String
var load_new_scene = false

var playing_level = false

func _process(_delta: float) -> void:
	if (load_new_scene):
		loading_status = ResourceLoader.load_threaded_get_status(load_path, progress)
		match loading_status:
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				pass
			ResourceLoader.THREAD_LOAD_LOADED:
				_change_scene()
			ResourceLoader.THREAD_LOAD_FAILED:
				load_new_scene = false
	if (Input.is_action_just_pressed("pause") and playing_level):
		get_tree().paused = true
		current_level.modulate = Color(1, 1, 1, 0.2)
		pause_menu.show()
		

func _change_scene() -> void:
	var level_scene = ResourceLoader.load_threaded_get(load_path)
	next_level = level_scene.instantiate()
	add_child(next_level)
	if (current_level != null):
		current_level.queue_free()
	current_level = next_level
	current_level.connect("won", _level_won)
	animation_player.play("blackout_fade_out")
	await animation_player.animation_finished
	load_new_scene = false

func change_scene(path: String) -> void:
	load_path = path
	ResourceLoader.load_threaded_request(path)
	animation_player.play("blackout_fade_in")
	await animation_player.animation_finished
	load_new_scene = true

func _level_won() -> void:
	if (current_level and current_level.next_level != -1):
		change_scene(levels[current_level.next_level])


func _on_main_menu_start_game() -> void:
	change_scene(levels[0])
	await animation_player.animation_finished
	main_menu.hide()
	playing_level = true


func _on_options_menu_close_options() -> void:
	options_menu.hide()


func _on_main_menu_show_options() -> void:
	options_menu.show()


func _on_pause_menu_show_options() -> void:
	options_menu.show()


func _on_pause_menu_resume() -> void:
	get_tree().paused = false
	current_level.modulate = Color(1, 1, 1, 1)
	pause_menu.hide()


func _on_pause_menu_quit_main_menu() -> void:
	get_tree().paused = false
	main_menu.show()
	pause_menu.hide()
	current_level.queue_free()
	playing_level = false
