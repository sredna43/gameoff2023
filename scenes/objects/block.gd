extends RigidBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Player):
		if (body.position.y > position.y):
			body.die(Globals.DEATH_BY.CRUSHED)
			linear_velocity = Vector2.ZERO
