@tool
extends Node2D

const SPRITE_LENGTH = 192

@export var gate_length: float = 224
@export var player_target: int

@onready var gate = $Gate
@onready var emitter1 = $Emitter1
@onready var emitter2 = $Emitter2
@onready var static_body = $Gate/StaticBody2D
@onready var animation_player = $AnimationPlayer


func _ready() -> void:
	gate.show()
	static_body.collision_mask = player_target * 2
	if (player_target == 1):
		static_body.set_collision_layer_value(6, true)
	if (player_target == 2):
		static_body.set_collision_layer_value(7, true)


func _process(_delta: float) -> void:
	if (player_target == 1):
		gate.modulate = Globals.P1_COLOR
	if (player_target == 2):
		gate.modulate = Globals.P2_COLOR
	emitter1.position.x = -(gate_length - 32) / 2 - 8
	emitter2.position.x = (gate_length - 32) / 2 + 8
	gate.scale.x = (gate_length - 32) / SPRITE_LENGTH


func disappear() -> void:
	animation_player.play("disappear")
	await animation_player.animation_finished
	gate.hide()


func reset() -> void:
	gate.show()
	static_body.collision_mask = player_target * 2
	if (player_target == 1):
		static_body.set_collision_layer_value(6, true)
	if (player_target == 2):
		static_body.set_collision_layer_value(7, true)
