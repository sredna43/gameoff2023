@tool
extends Node2D

signal pressed

@export var player_target = 0

@onready var sprite = $Sprite
@onready var area = $Area2D
@onready var static_body = $StaticBody2D
@onready var pressed_collision = $StaticBody2D/Pressed
@onready var released_collision = $StaticBody2D/Released

var is_pressed = false

func _ready() -> void:
	sprite.frame = player_target * 2

func _process(_delta: float) -> void:
	if (Engine.is_editor_hint()):
		sprite.frame = player_target * 2
	else:
		if (player_target == 0):
			area.set_collision_mask_value(2, true)
			area.set_collision_mask_value(4, true)
			area.set_collision_mask_value(3, true)
			area.set_collision_mask_value(5, true)
		elif (player_target == 1):
			area.set_collision_mask_value(2, true)
			area.set_collision_mask_value(4, true)
			area.set_collision_mask_value(3, false)
			area.set_collision_mask_value(5, false)
		elif (player_target == 2):
			area.set_collision_mask_value(3, true)
			area.set_collision_mask_value(5, true)
			area.set_collision_mask_value(2, false)
			area.set_collision_mask_value(4, false)


func _on_area_2d_body_entered(_body):
	if (not is_pressed):
		emit_signal("pressed")
	is_pressed = true
	sprite.frame = player_target * 2 + 1


func _on_area_2d_body_exited(_body):
	if (!area.has_overlapping_bodies()):
		is_pressed = false
		sprite.frame = player_target * 2
