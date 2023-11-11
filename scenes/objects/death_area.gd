extends Area2D

@export var death_by: Globals.DEATH_BY = Globals.DEATH_BY.FALL

func _on_body_entered(body: Node2D) -> void:
	print("Body: ", body)
	if (body is Player):
		body.die(death_by)
