extends PlayerState

func enter() -> void:
	player.velocity = Vector2.ZERO

func run(delta: float) -> String:
	if (Input.is_action_just_pressed("p%d_jump" % player.player_num)):
		player.leave_goal()
		return "jump"
	if (input != 0 and abs(player.position - player.goal_pos) < Vector2.ONE):
		player.leave_goal()
		return "run"
	
	player.position = lerp(player.position, player.goal_pos, 0.1)
	return super(delta)
