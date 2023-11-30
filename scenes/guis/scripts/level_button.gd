extends TextureButton
class_name LevelButton

signal level_selected(level_number)

@onready var label = $Label
@onready var locked = $MarginContainer/Locked

@export var level_number = ""

func _ready() -> void:
	if (level_number == "locked"):
		locked.show()
		label.hide()
		disabled = true
	else:
		locked.hide()
		label.show()
		label.text = level_number
		disabled = false


func _on_pressed() -> void:
	emit_signal("level_selected", level_number)
