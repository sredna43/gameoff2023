extends CanvasLayer

signal resume
signal restart
signal show_options
signal show_controls
signal quit_main_menu

@onready var pause_menu = $PauseMenu
@onready var confirm_menu = $Confirm

@onready var resume_button = $PauseMenu/MarginContainer/Buttons/Resume
@onready var restart_button = $PauseMenu/MarginContainer/Buttons/Restart
@onready var options_button = $PauseMenu/MarginContainer/Buttons/Options
@onready var controls_button = $PauseMenu/MarginContainer/Buttons/Controls
@onready var main_menu_button = $PauseMenu/MarginContainer/Buttons/MainMenu

@onready var back_button = $Confirm/MarginContainer/HBoxContainer/Back
@onready var quit_button = $Confirm/MarginContainer/HBoxContainer/Quit

@onready var all_buttons = [resume_button, restart_button, options_button, controls_button, main_menu_button, back_button, quit_button]

var buttons = []
var on_button = 0

enum screens {MAIN, CONFIRM, OTHER}
var on_screen = screens.MAIN

var just_opened = true

func _ready() -> void:
	for button in all_buttons:
		button.connect("focus_entered", _on_button_focused)


func _process(_delta: float) -> void:
	if (visible):
		if (on_screen == screens.MAIN):
			buttons = [resume_button, restart_button, options_button, controls_button, main_menu_button]
		elif (on_screen == screens.CONFIRM):
			buttons = [back_button, quit_button]
			while on_button > buttons.size() - 1:
				on_button -= 1
		else:
			buttons = []
		for button in buttons:
			if (button.is_hovered()):
				button.grab_focus()
				on_button = buttons.find(button, 0)
		if (buttons.size() > 0):
			if (Input.is_action_just_pressed("ui_accept")):
				for button in buttons:
					if (button.has_focus()):
						button.emit_signal("pressed")
			if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left")):
				if (on_button > 0):
					on_button -= 1
				else:
					on_button = buttons.size() - 1
			if (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right")):
				if (on_button < buttons.size() - 1):
					on_button += 1
				else:
					on_button = 0
			buttons[on_button].grab_focus()
		if (Input.is_action_just_pressed("ui_text_backspace")):
			if (on_screen == screens.MAIN):
				emit_signal("resume")
			elif (on_screen == screens.CONFIRM):
				pause_menu.modulate = Color(1, 1, 1, 1)
				confirm_menu.hide()
			on_screen = screens.MAIN
		if (Input.is_action_just_released("pause")):
			just_opened = false
		if (Input.is_action_just_pressed("pause") and not just_opened):
			_on_resume_pressed()


func _on_resume_pressed() -> void:
	just_opened = true
	AudioPlayer.button_press()
	emit_signal("resume")
	on_screen = screens.MAIN


func _on_restart_pressed() -> void:
	just_opened = true
	AudioPlayer.button_press()
	emit_signal("restart")
	on_screen = screens.MAIN


func _on_options_pressed() -> void:
	just_opened = true
	AudioPlayer.button_press()
	emit_signal("show_options")
	on_screen = screens.OTHER


func _on_main_menu_pressed() -> void:
	just_opened = true
	AudioPlayer.button_press()
	confirm_menu.show()
	pause_menu.modulate = Color(1, 1, 1, 0.2)
	on_screen = screens.CONFIRM


func _on_back_pressed() -> void:
	just_opened = true
	AudioPlayer.button_press()
	pause_menu.modulate = Color(1, 1, 1, 1)
	confirm_menu.hide()
	on_screen = screens.MAIN


func _on_quit_pressed() -> void:
	just_opened = true
	AudioPlayer.button_press()
	emit_signal("quit_main_menu")
	pause_menu.modulate = Color(1, 1, 1, 1)
	confirm_menu.hide()
	on_screen = screens.MAIN



func _on_controls_pressed() -> void:
	AudioPlayer.button_press()
	emit_signal("show_controls")
	on_screen = screens.OTHER


func _on_button_focused() -> void:
	AudioPlayer.button_focus()
