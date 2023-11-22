@tool
extends Area2D

@export var player_target: int 

@onready var sprite = $Sprite2D

func _ready() -> void:
	collision_mask = player_target * 2

func _process(_delta: float) -> void:
	_set_color()

func _set_color() -> void:
	if player_target == 1:
		sprite.set_modulate(Globals.P1_COLOR)
	elif player_target == 2:
		sprite.set_modulate(Globals.P2_COLOR)

func _on_body_entered(body):
	if body is Player and body.player_num == player_target:
		body.go_to_goal(position)
