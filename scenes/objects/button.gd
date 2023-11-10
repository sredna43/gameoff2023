extends Node2D

@onready var sprite = $Sprite
@onready var area = $Area2D
signal pressed

func _ready() -> void:
	sprite.frame = 0

func _on_area_2d_body_entered(_body):
	sprite.frame = 1
	emit_signal("pressed")

func _on_area_2d_body_exited(_body):
	if (!area.has_overlapping_bodies()):
		sprite.frame = 0
