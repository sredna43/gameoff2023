extends CanvasLayer

signal level_selected(level: String)
signal back_pressed

@onready var button_container = $LevelSelect/MarginContainer/VBoxContainer/CenterContainer/ButtonContainer
@onready var back_button = $LevelSelect/MarginContainer/BackButton

var LevelButtonInstance = preload("res://scenes/guis/level_button.tscn")
var new_button: LevelButton
var on_button = 0
var buttons: Array[Node] = []
var levels: Array[String] = []


func _process(_delta: float) -> void:
	if (visible):
		buttons = button_container.get_children()
		buttons.push_back(back_button)
		for button in buttons:
			assert(button is TextureButton, "All children of LevelSelect's Button Container must be TextureButtons")
			if (button.is_hovered() and not button.disabled):
				button.grab_focus()
				on_button = buttons.find(button, 0)
		if (Input.is_action_just_pressed("ui_accept")):
			for button in buttons:
				if (button.has_focus()):
					button.emit_signal("pressed")
		if (Input.is_action_just_pressed("ui_right")):
			if (on_button < buttons.size() - 1 and not buttons[on_button + 1].disabled):
				on_button += 1
		if (Input.is_action_just_pressed("ui_left")):
			if (on_button > 0 and not buttons[on_button - 1].disabled):
				on_button -= 1
		if (Input.is_action_just_pressed("ui_up")):
			if (on_button > button_container.columns or on_button == buttons.size() - 1 and not buttons[clamp(on_button - button_container.columns, 0, buttons.size() - 1)].disabled):
				on_button = clamp(on_button - button_container.columns, 0, buttons.size() - 1)
		if (Input.is_action_just_pressed("ui_down") and not buttons[clamp(on_button + button_container.columns, 0, buttons.size() - 1)].disabled):
			if (on_button < button_container.columns):
				on_button = clamp(on_button + button_container.columns, 0, buttons.size() - 1)
		if (Input.is_action_just_pressed("ui_text_backspace")):
			_on_back_button_pressed()
		if (not buttons[on_button].disabled):
			buttons[on_button].grab_focus()


func setup_level_buttons() -> void:
	for old in button_container.get_children():
		old.queue_free()
	for level in levels:
		new_button = LevelButtonInstance.instantiate()
		new_button.connect("level_selected", _on_level_button_pressed)
		new_button.level_number = level
		button_container.add_child(new_button)


func _on_level_button_pressed(selected_level: String) -> void:
	emit_signal("level_selected", selected_level)


func _on_back_button_pressed() -> void:
	emit_signal("back_pressed")
