extends Node2D

@onready var removable_platform = $RemovablePlatform

func _ready() -> void:
	$MultitargetCamera.add_target($Player1)
	$MultitargetCamera.add_target($Player2)

func _on_button_pressed():
	removable_platform.disappear()
