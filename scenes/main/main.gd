extends Node2D

const levels = {
	0: "res://scenes/levels/level_0.tscn",
	1: "res://scenes/levels/level_1.tscn"
}

@onready var animation_player = $AnimationPlayer
@onready var blackout = $Blackout

var current_level: Level
var next_level: Level

var loading_status: int
var progress: Array[float]

var load_path: String
var load_new_scene = false

func _ready() -> void:
	change_scene(levels[0])

func _process(_delta: float) -> void:
	if (load_new_scene):
		loading_status = ResourceLoader.load_threaded_get_status(load_path, progress)
		match loading_status:
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				pass
			ResourceLoader.THREAD_LOAD_LOADED:
				var level_scene = ResourceLoader.load_threaded_get(load_path)
				next_level = level_scene.instantiate()
				add_child(next_level)
				if (current_level != null):
					current_level.queue_free()
				current_level = next_level
				current_level.connect("won", _level_won)
				animation_player.play("blackout_fade_out")
				load_new_scene = false
			ResourceLoader.THREAD_LOAD_FAILED:
				load_new_scene = false

func change_scene(path: String) -> void:
	load_path = path
	ResourceLoader.load_threaded_request(path)
	animation_player.play("blackout_fade_in")
	load_new_scene = true

func _level_won() -> void:
	if (current_level and current_level.next_level != -1):
		change_scene(levels[current_level.next_level])
