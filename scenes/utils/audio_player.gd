extends Node

@onready var button_press_sound = $ButtonPress
@onready var button_focus_sound = $ButtonFocus
@onready var won_sound = $Won
@onready var music = $Music


func _process(_delta: float) -> void:
	if (get_tree().paused):
		music.volume_db = -15
	else:
		music.volume_db = -10
	if (Globals.play_music and not music.playing):
		music.stream_paused = false
	elif (not Globals.play_music and music.playing):
		music.stream_paused = true


func start_music() -> void:
	if (not music.playing):
		music.play(0.0)


func button_press() -> void:
	if (Globals.play_sounds):
		button_press_sound.play(0.0)


func button_focus() -> void:
	if (Globals.play_sounds and not button_press_sound.playing):
		button_focus_sound.play(0.0)


func won() -> void:
	if (Globals.play_sounds):
		won_sound.play(0.0)
