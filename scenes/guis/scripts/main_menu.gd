extends CanvasLayer

signal start_game
signal show_options
signal show_controls

@onready var main = $Main

@onready var play_button: TextureButton = $Main/TitleAndButtons/CenterContainer/Buttons/StartContainer/Play
@onready var controls_button: TextureButton = $Main/TitleAndButtons/CenterContainer/Buttons/ControlsContainer/Controls
@onready var options_button: TextureButton = $Main/TitleAndButtons/CenterContainer/Buttons/OptionsContainer/Options

@onready var buttons = [play_button, controls_button, options_button]
var on_button = 0

enum screens {MAIN_MENU, OTHER}
var on_screen = screens.MAIN_MENU


func _ready() -> void:
	play_button.grab_focus()


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
				on_button = buttons.size() - 1
			buttons[on_button].grab_focus()
		if (Input.is_action_just_pressed("ui_down")):
			if (on_button < buttons.size() - 1):
				on_button += 1
			else:
				on_button = 0
		buttons[on_button].grab_focus()


func _on_start_pressed() -> void:
	on_screen = screens.OTHER
	emit_signal("start_game")


func _on_options_pressed() -> void:
	on_screen = screens.OTHER
	emit_signal("show_options")


func _on_controls_pressed() -> void:
	on_screen = screens.OTHER
	emit_signal("show_controls")
