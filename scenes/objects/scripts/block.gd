extends RigidBody2D

var initial_position: Vector2


func _ready() -> void:
	initial_position = global_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Player and body.position.y > position.y):
		body.die(Globals.DEATH_BY.CRUSHED)
		linear_velocity = Vector2.ZERO


func reset() -> void:
	set_global_position(initial_position)
