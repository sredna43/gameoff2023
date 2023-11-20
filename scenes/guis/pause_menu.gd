extends CanvasLayer

signal resume
signal show_options
signal quit_main_menu

@onready var pause_menu = $PauseMenu
@onready var confirm_menu = $Confirm

@onready var resume_button = $PauseMenu/MarginContainer/MarginContainer/Buttons/Resume
@onready var options_button = $PauseMenu/MarginContainer/MarginContainer/Buttons/Options
@onready var main_menu_button = $PauseMenu/MarginContainer/MarginContainer/Buttons/MainMenu

@onready var buttons = [resume_button, options_button, main_menu_button]
var on_button = 0

func _process(_delta: float) -> void:
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


func _on_resume_pressed() -> void:
	emit_signal("resume")


func _on_options_pressed() -> void:
	emit_signal("show_options")


func _on_main_menu_pressed() -> void:
	confirm_menu.show()
	pause_menu.modulate = Color(1, 1, 1, 0.2)


func _on_back_pressed() -> void:
	pause_menu.modulate = Color(1, 1, 1, 1)
	confirm_menu.hide()


func _on_quit_pressed() -> void:
	emit_signal("quit_main_menu")
