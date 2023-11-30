extends CanvasLayer

signal start_game
signal show_options
signal show_controls
signal show_credits
signal button_focus_changed

@onready var main = $Main

@onready var play_button: TextureButton = $Main/TitleAndButtons/CenterContainer/Buttons/StartContainer/Play
@onready var controls_button: TextureButton = $Main/TitleAndButtons/CenterContainer/Buttons/ControlsContainer/Controls
@onready var options_button: TextureButton = $Main/TitleAndButtons/CenterContainer/Buttons/OptionsContainer/Options
@onready var credits_button: TextureButton = $Footer/CreditsButton
@onready var version_label: Label = $Footer/Version

@onready var buttons = [play_button, controls_button, options_button, credits_button]
var on_button = 0

enum screens {MAIN_MENU, OTHER}
var on_screen = screens.MAIN_MENU


func _ready() -> void:
	version_label.text = Globals.VERSION
	play_button.grab_focus()
	for button in buttons:
		button.connect("focus_entered", _on_button_focused)


func _process(_delta: float) -> void:
	if (on_screen == screens.MAIN_MENU):
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
				on_button = buttons.size() - 2
			buttons[on_button].grab_focus()
		if (Input.is_action_just_pressed("ui_down")):
			if (on_button < buttons.size() - 2):
				on_button += 1
			else:
				on_button = 0
		if (Input.is_action_just_pressed("ui_left")):
			on_button = buttons.size() - 1
		if (Input.is_action_just_pressed("ui_right") and on_button == buttons.size() - 1):
			on_button = 0
		buttons[on_button].grab_focus()


func _on_start_pressed() -> void:
	on_screen = screens.OTHER
	AudioPlayer.button_press()
	emit_signal("start_game")


func _on_options_pressed() -> void:
	on_screen = screens.OTHER
	AudioPlayer.button_press()
	emit_signal("show_options")


func _on_controls_pressed() -> void:
	on_screen = screens.OTHER
	AudioPlayer.button_press()
	emit_signal("show_controls")


func _on_credits_button_pressed() -> void:
	on_screen = screens.OTHER
	AudioPlayer.button_press()
	emit_signal("show_credits")

func _on_button_focused() -> void:
	AudioPlayer.button_focus()
