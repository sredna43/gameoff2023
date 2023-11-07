extends Node2D

@onready var sprite = $RemovablePlatform
@onready var static_body = $StaticBody2D
@onready var animation_player = $AnimationPlayer

func disappear() -> void:
	animation_player.play("disappear")
