@tool
extends CharacterBody2D
class_name Player

"""
Exported variables
"""
@export var player_num = 0
@export var respawn_marker: Marker2D


"""
Gameplay variables
"""
var speed = 20
var gravity = 18
var friction = 0.2
var jump_strength = 400
var wall_jump_strength = 275
var wall_jump_kick = 400
var terminal_velocity = 1000
var air_resistance = 0.05
var max_speed = 300
var respawn_position: Vector2 = Vector2.ZERO


"""
State variables
"""
var on_wall = 0
var can_become_platform = true
var is_platform = false
var going_to_goal = false
var in_goal = false
var goal_pos: Vector2
var dead = false
var respawning = false
var just_hit_ground = false
var previous_velocity: Vector2
var on_moving_platform = false


"""
onready variables
"""
@onready var fsm: StateMachine = $StateMachine
@onready var left_collider = $LeftCollider
@onready var right_collider = $RightCollider
@onready var area = $PlatformArea
@onready var expand_icon = $Sprite2D/ExpandIcon
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var jump_sound: AudioStreamPlayer2D = $Jump
@onready var platform_sound: AudioStreamPlayer2D = $Platform
@onready var die_sound: AudioStreamPlayer2D = $Die


"""
Internal functions
"""
func _ready():
	if (player_num == 1):
		collision_layer = 2
		set_collision_mask_value(6, false)
		set_collision_mask_value(7, true)
	elif (player_num == 2):
		collision_layer = 4
		set_collision_mask_value(6, true)
		set_collision_mask_value(7, false)
	if (respawn_marker):
		respawn_position = respawn_marker.position
	collision.disabled = false


func _physics_process(delta) -> void:
	# Sets color in editor
	if (player_num == 1):
		sprite.set_modulate(Globals.P1_COLOR)
	elif (player_num == 2):
		sprite.set_modulate(Globals.P2_COLOR)
	
	if not Engine.is_editor_hint():
		_get_wall_collision()
		_check_is_in_goal()
		_handle_expand_icon_visibility()
		
		if (respawning):
			_do_respawn(delta)
		else:
			show()
			sprite.self_modulate = Color(1, 1, 1, 1)
		
		fsm.run(delta)
		
		_update_velocity(delta)
		move_and_slide()
		_do_squash_and_stretch(delta)


func _update_velocity(delta: float) -> void:
	position += velocity * delta
	previous_velocity = velocity


func _do_respawn(delta: float) -> void:
	position = lerp(position, respawn_position, 10 * delta)
	velocity = Vector2.ZERO
	if (position.distance_to(respawn_position) < 10):
		is_platform = false
		respawning = false
		dead = false
		collision.disabled = false


func _handle_expand_icon_visibility() -> void:
	if (in_goal or dead):
		expand_icon.visible = false
	else:
		expand_icon.visible = !is_platform


func _check_is_in_goal() -> void:
	if (abs(position - goal_pos) < Vector2.ONE):
		in_goal = true
	else:
		in_goal = false


func _get_wall_collision() -> void:
	if (left_collider.is_colliding()):
		on_wall = -1
	elif (right_collider.is_colliding()):
		on_wall = 1
	else:
		on_wall = 0


func _do_squash_and_stretch(delta: float) -> void:
	if (going_to_goal):
		sprite.scale = Vector2.ONE
		return
	if (is_platform):
		return
	if (not in_goal and not on_wall):
		if (not is_on_floor()):
			just_hit_ground = false
			sprite.scale.y = remap(abs(velocity.y), 0, abs(jump_strength), 0.90, 1.10)
			sprite.scale.x = remap(abs(velocity.y), 0, abs(jump_strength), 1.15, 0.85)
		
		if (not just_hit_ground and is_on_floor()):
			just_hit_ground = true
			sprite.scale = Vector2.ONE
	
	sprite.scale.x = lerp(sprite.scale.x, 1.0, 1 - pow(0.01, delta))
	sprite.scale.y = lerp(sprite.scale.y, 1.0, 1 - pow(0.01, delta))


func _on_area_2d_area_entered(_area: Area2D) -> void:
	can_become_platform = false
	animation_player.play("hide_expand")


func _on_area_2d_area_exited(_area: Area2D) -> void:
	can_become_platform = true
	animation_player.play("show_expand")


"""
External functions, called by other nodes
"""
func respawn() -> void:
		respawning = true


func die(by: Globals.DEATH_BY) -> void:
	if (!in_goal and !dead):
		print("Death by: %s" % Globals.DEATH_BY.keys()[by])
		dead = true
		animation_player.play("die")
		await get_tree().create_timer(1.2).timeout
		hide()
		respawning = true


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


func _on_floor_area_body_entered(_body: Node2D) -> void:
	on_moving_platform = true


func _on_floor_area_body_exited(_body: Node2D) -> void:
	on_moving_platform = false
