@tool
extends Node2D

@export var player_target: int = 0

@onready var pole = $Pole
@onready var flag = $Pole/Flag
@onready var respawn_marker = $RespawnMarker
@onready var animation_player = $AnimationPlayer
@onready var area = $Area2D

var has_been_reached = false


func _ready() -> void:
	if (player_target == 1):
		area.set_collision_mask_value(2, true)
	if (player_target == 2):
		area.set_collision_mask_value(3, true)


func _process(_delta: float) -> void:
	if (player_target == 1):
		flag.self_modulate = Globals.P1_COLOR
	if (player_target == 2):
		flag.self_modulate = Globals.P2_COLOR


func _reached(player: Player) -> void:
	player.respawn_position = respawn_marker.global_position
	animation_player.play("reached")
	has_been_reached = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Player and not has_been_reached):
		_reached(body)
