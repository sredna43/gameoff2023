@tool
extends Node2D
class_name PlayerGate

const SPRITE_LENGTH = 192

@export var gate_length: float = 224
@export var player_target: int

@onready var gate = $Gate
@onready var emitter1 = $Emitter1
@onready var emitter2 = $Emitter2
@onready var static_body = $Gate/StaticBody2D
@onready var collider = $Gate/StaticBody2D/CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var sound_effect = $SoundEffect


func _ready() -> void:
	gate.show()


func _process(_delta: float) -> void:
	if (player_target == 1):
		gate.modulate = Globals.P1_COLOR
		if (gate.visible):
			static_body.set_collision_layer_value(6, true)
			static_body.set_collision_layer_value(7, false)
	if (player_target == 2):
		gate.modulate = Globals.P2_COLOR
		if (gate.visible):
			static_body.set_collision_layer_value(6, false)
			static_body.set_collision_layer_value(7, true)
	emitter1.position.x = -(gate_length - 32) / 2 - 8
	emitter2.position.x = (gate_length - 32) / 2 + 8
	gate.scale.x = (gate_length - 32) / SPRITE_LENGTH
	if (not Engine.is_editor_hint()):
		if (!gate.visible):
			sound_effect.stream_paused = true
			static_body.set_collision_layer_value(6, false)
			static_body.set_collision_layer_value(7, false)
		elif (gate.visible and not sound_effect.playing):
			if (Globals.play_sounds):
				sound_effect.stream_paused = false
			else:
				sound_effect.stream_paused = true


func disappear() -> void:
	animation_player.play("disappear")
	await animation_player.animation_finished
	gate.hide()


func reset() -> void:
	gate.show()
	if (player_target == 1):
		static_body.set_collision_layer_value(6, true)
	if (player_target == 2):
		static_body.set_collision_layer_value(7, true)
