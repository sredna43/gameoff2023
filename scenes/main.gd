extends Node2D

const levels: Dictionary = {
	"1": "res://scenes/levels/level_1.tscn",
	"2": "res://scenes/levels/level_2.tscn",
	"3": "res://scenes/levels/level_3.tscn",
	"4": "res://scenes/levels/level_4.tscn",
	"5": "res://scenes/levels/level_5.tscn"
}

@onready var animation_player = $AnimationPlayer
@onready var blackout = $Blackout
@onready var main_menu = $MainMenu
@onready var options_menu = $OptionsMenu
@onready var pause_menu = $PauseMenu
@onready var level_select = $LevelSelect
@onready var level_won = $LevelWon

var current_level: Level
var next_level: Level
var current_level_tag: String
var unlocked_levels: Array[String] = ["1"]

var loading_status: int
var progress: Array[float]

var load_path: String
var load_new_scene = false

var playing_level = false


func _ready() -> void:
	_setup_selectable_levels()


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
		pause_menu.on_screen = pause_menu.screens.MAIN
		pause_menu.show()


func _change_scene() -> void:
	var level_scene = ResourceLoader.load_threaded_get(load_path)
	next_level = level_scene.instantiate()
	add_child(next_level)
	if (current_level):
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


func _on_main_menu_start_game() -> void:
	main_menu.hide()
	level_select.show()


func _on_options_menu_close_options() -> void:
	options_menu.hide()
	if (main_menu.visible):
		main_menu.on_screen = main_menu.screens.MAIN_MENU
	elif (pause_menu.visible):
		pause_menu.on_screen = pause_menu.screens.MAIN


func _on_main_menu_show_options() -> void:
	options_menu.show()


func _on_pause_menu_show_options() -> void:
	options_menu.show()


func _on_pause_menu_resume() -> void:
	get_tree().paused = false
	current_level.modulate = Color(1, 1, 1, 1)
	pause_menu.hide()


func _on_pause_menu_restart() -> void:
	get_tree().paused = false
	current_level.modulate = Color(1, 1, 1, 1)
	current_level.restart()
	pause_menu.hide()


func _on_pause_menu_quit_main_menu() -> void:
	get_tree().paused = false
	main_menu.show()
	main_menu.on_screen = main_menu.screens.MAIN_MENU
	current_level.hide()
	pause_menu.hide()
	playing_level = false


func _setup_selectable_levels() -> void:
	level_select.levels.clear()
	for level_key in levels.keys():
		if (level_key not in unlocked_levels):
			level_select.levels.push_back("locked")
		else:
			level_select.levels.push_back(level_key)
	level_select.setup_level_buttons()


func _on_level_select_level_selected(level: String) -> void:
	level_select.hide()
	playing_level = true
	get_tree().paused = false
	current_level_tag = level
	change_scene(levels[level])


func _level_won() -> void:
	if (current_level):
		get_tree().paused = true
		unlocked_levels.push_back(current_level.next_level)
		current_level.modulate = Color(1, 1, 1, 0.2)
		playing_level = false
		_setup_selectable_levels()
		level_won.show()


func _on_level_won_level_select() -> void:
	level_won.hide()
	current_level.hide()
	level_select.show()


func _on_level_won_next_level() -> void:
	level_won.hide()
	if (current_level.next_level != "-1"):
		current_level_tag = current_level.next_level
		change_scene(levels[current_level.next_level])
		get_tree().paused = false
		playing_level = true
	else:
		current_level.hide()
		main_menu.show()
		main_menu.on_screen = main_menu.screens.MAIN_MENU


func _on_level_won_main_menu() -> void:
	level_won.hide()
	current_level.hide()
	main_menu.show()
	main_menu.on_screen = main_menu.screens.MAIN_MENU


func _on_level_select_back_pressed() -> void:
	level_select.hide()
	main_menu.show()
	main_menu.on_screen = main_menu.screens.MAIN_MENU
