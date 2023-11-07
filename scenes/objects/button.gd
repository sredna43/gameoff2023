extends Node2D

@onready var sprite = $Sprite

func _ready() -> void:
	sprite.frame = 0

func _on_area_2d_body_entered(body):
	sprite.frame = 1

func _on_area_2d_body_exited(body):
	sprite.frame = 0
