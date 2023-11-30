extends CanvasLayer

signal close_options

@onready var music_off_button = $OptionsMenu/OptionsContainer/VBoxContainer/SoundOptions/Icons/MusicOffButton
@onready var music_on_button = $OptionsMenu/OptionsContainer/VBoxContainer/SoundOptions/Icons/MusicOnButton
@onready var sounds_off_button = $OptionsMenu/OptionsContainer/VBoxContainer/SoundOptions/Icons/SoundEffectsOffButton
@onready var sounds_on_button = $OptionsMenu/OptionsContainer/VBoxContainer/SoundOptions/Icons/SoundEffectsOnButton
@onready var accept_button = $OptionsMenu/OptionsContainer/MarginContainer/ButtonsContainer/AcceptButton

var music_button: TextureButton
var sound_button: TextureButton

var on_button = 0
var buttons = []
@onready var all_buttons = [music_off_button, music_on_button, sounds_off_button, sounds_on_button, accept_button]

func _ready() -> void:
	for button in all_buttons:
		button.connect("focus_entered", _on_button_focused)

func _process(_delta: float) -> void:
	if (Globals.play_music):
		music_button = music_on_button
		music_on_button.visible = true
		music_off_button.visible = false
	else:
		music_button = music_off_button
		music_on_button.visible = false
		music_off_button.visible = true
	if (Globals.play_sounds):
		sound_button = sounds_on_button
		sounds_on_button.visible = true
		sounds_off_button.visible = false
	else:
		sound_button = sounds_off_button
		sounds_on_button.visible = false
		sounds_off_button.visible = true
	
	buttons = [music_button, sound_button, accept_button]
	if (visible):
		for button in buttons:
			if (button.is_hovered()):
				button.grab_focus()
				on_button = buttons.find(button, 0)
		if (Input.is_action_just_pressed("ui_accept")):
			for button in buttons:
				if (button.has_focus()):
					button.emit_signal("pressed")
		if (Input.is_action_just_pressed("ui_up")):
			if (on_button > 0):
				on_button -= 1
			else:
				on_button = buttons.size() - 1
			buttons[on_button].grab_focus()
		if (Input.is_action_just_pressed("ui_down")):
			if (on_button < buttons.size() - 1):
				on_button += 1
			else:
				on_button = 0
		buttons[on_button].grab_focus()


func _on_accept_button_pressed() -> void:
	AudioPlayer.button_press()
	emit_signal("close_options")


func _on_sound_effects_button_pressed() -> void:
	Globals.play_sounds = !Globals.play_sounds
	AudioPlayer.button_press()


func _on_music_button_pressed() -> void:
	Globals.play_music = !Globals.play_music
	AudioPlayer.button_press()


func _on_button_focused() -> void:
	AudioPlayer.button_focus()
