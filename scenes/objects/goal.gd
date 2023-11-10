extends Area2D

@export var player_target: int 

func _ready() -> void:
	var sprite = $Sprite2D
	if player_target == 1:
		sprite.set_modulate(Globals.P1_COLOR)
	elif player_target == 2:
		sprite.set_modulate(Globals.P2_COLOR)

func _on_body_entered(body):
	if body is Player and body.player_num == player_target:
		body.go_to_goal(position)
