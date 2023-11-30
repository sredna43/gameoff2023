extends CanvasLayer

signal back_button_pressed


@onready var back_button = $Controls/BackButtonContainer/BackButton


func _process(_delta: float) -> void:
	if (visible):
		back_button.grab_focus()
		if (Input.is_action_just_pressed("ui_text_backspace")):
			emit_signal("back_button_pressed")


func _on_back_button_pressed() -> void:
	emit_signal("back_button_pressed")
