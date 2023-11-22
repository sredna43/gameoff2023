extends Node2D

signal pressed

@export var player_target = 0

@onready var sprite = $Sprite
@onready var area = $Area2D
@onready var static_body = $StaticBody2D

func _ready() -> void:
	sprite.frame = player_target * 2
	if (player_target == 0):
		static_body.collision_mask = 6
		area.collision_mask = 6
	else:
		static_body.collision_mask = player_target * 2
		area.collision_mask = player_target * 2


func _on_area_2d_body_entered(_body):
	sprite.frame = player_target * 2 + 1
	emit_signal("pressed")


func _on_area_2d_body_exited(_body):
	if (!area.has_overlapping_bodies()):
		sprite.frame = player_target * 2
