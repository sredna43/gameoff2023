extends Node2D

@onready var sprite = $Sprite
@onready var static_body = $StaticBody2D
@onready var animation_player = $AnimationPlayer

var can_disappear = true

func disappear() -> void:
	if (can_disappear):
		animation_player.play("disappear")
		can_disappear = false


func reset() -> void:
	animation_player.play("RESET")
	can_disappear = true
