extends CharacterBody2D
class_name Player

@export var player_num = 0
@export var respawn_marker: Marker2D

var speed = 20
var gravity = 18
var friction = 0.2
var jump_strength = 420
var terminal_velocity = 1500
var air_resistance = 0.05
var max_speed = 300
var wall_jump_strength = 225
var wall_jump_kick = 270
var respawn_position: Vector2

var on_wall = 0
var can_become_platform = true
var is_platform = false
var going_to_goal = false
var in_goal = false
var goal_pos: Vector2
var dead = false
var respawning = false

@onready var fsm: StateMachine = $StateMachine
@onready var left_collider = $LeftCollider
@onready var right_collider = $RightCollider
@onready var area = $PlatformArea
@onready var expand_icon = $ExpandIcon
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	if (player_num == 1):
		sprite.set_modulate(Globals.P1_COLOR)
	elif (player_num == 2):
		sprite.set_modulate(Globals.P2_COLOR)
	respawn_position = respawn_marker.position
	collision.disabled = false

func _physics_process(delta) -> void:
	if (left_collider.is_colliding()):
		on_wall = -1
	elif (right_collider.is_colliding()):
		on_wall = 1
	else:
		on_wall = 0
	
	if (abs(position - goal_pos) < Vector2.ONE):
		in_goal = true
	else:
		in_goal = false

	if (in_goal or dead):
		expand_icon.visible = false
	else:
		expand_icon.visible = !is_platform
	
	if (respawning):
		position = lerp(position, respawn_position, 10 * delta)
		velocity = Vector2.ZERO
		if (position.distance_to(respawn_position) < 3.5):
			respawning = false
			dead = false
			velocity.y = -jump_strength
	
	fsm.run(delta)
	
	position += velocity * delta
	move_and_slide()

func go_to_goal(_goal_pos: Vector2) -> void:
	goal_pos = _goal_pos
	going_to_goal = true
	if (can_become_platform):
		animation_player.play("hide_expand")

func leave_goal() -> void:
	in_goal = false
	going_to_goal = false
	if (can_become_platform):
		animation_player.play("show_expand")

func die(by: Globals.DEATH_BY) -> void:
	if (!in_goal and !dead):
		print(Globals.DEATH_BY.keys()[by])
		dead = true
		animation_player.play("die")

func respawn() -> void:
	respawning = true

func _on_area_2d_area_entered(_area: Area2D) -> void:
	can_become_platform = false
	animation_player.play("hide_expand")

func _on_area_2d_area_exited(_area: Area2D) -> void:
	can_become_platform = true
	animation_player.play("show_expand")
