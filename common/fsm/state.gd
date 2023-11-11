extends Node
class_name State

@export var tag: String

func _ready() -> void:
	assert(tag != null && tag != "", "State Tag cannot be null or empty")

func run(_delta: float) -> String:
	return ""

func enter() -> void:
	pass

func exit() -> void:
	pass
