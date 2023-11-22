extends CanvasLayer

signal next_level
signal level_select
signal main_menu

@onready var next_level_button = $LevelWonMenu/MarginContainer/MarginContainer/Buttons/NextLevel
@onready var level_select_button = $LevelWonMenu/MarginContainer/MarginContainer/Buttons/LevelSelect
@onready var main_menu_button = $LevelWonMenu/MarginContainer/MarginContainer/Buttons/MainMenu

@onready var buttons = [next_level_button, level_select_button, main_menu_button]
var on_button = 0


func _process(_delta: float) -> void:
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


func _on_next_level_pressed() -> void:
	emit_signal("next_level")


func _on_level_select_pressed() -> void:
	emit_signal("level_select")


func _on_main_menu_pressed() -> void:
	emit_signal("main_menu")
