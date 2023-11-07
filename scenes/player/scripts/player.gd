extends CharacterBody2D
class_name Player

@export var player_num = 0

var speed = 20
var gravity = 12
var friction = 0.2
var jump_strength = 300
var terminal_velocity = 1000
var air_resistance = 0.05
var max_speed = 300
var wall_jump_strength = 140
var wall_jump_kick = 310

var on_wall = 0
var can_become_platform = true
var is_platform = false

@onready var fsm: StateMachine = $StateMachine
@onready var left_collider = $LeftCollider
@onready var right_collider = $RightCollider
@onready var area = $PlatformArea
@onready var expand_icon = $ExpandIcon
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _physics_process(delta) -> void:
	if (left_collider.is_colliding()):
		on_wall = -1
	elif (right_collider.is_colliding()):
		on_wall = 1
	else:
		on_wall = 0
	
	expand_icon.visible = !is_platform
	
	fsm.run(delta)
	
	position += velocity * delta
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	can_become_platform = false
	animation_player.play("hide_expand")

func _on_area_2d_area_exited(area: Area2D) -> void:
	can_become_platform = true
	animation_player.play("show_expand")
