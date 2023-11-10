extends PlayerState

func run(delta: float) -> String:
	if (!player.is_on_floor()):
		return "air"
	if (input != 0.0):
		return "run"
	if (Input.is_action_pressed("p%d_jump" % player.player_num)):
		return "jump"
	if (Input.is_action_pressed("p%d_platform" % player.player_num) and player.can_become_platform):
		return "platform"
	if (player.going_to_goal):
		return "in_goal"
	if (player.dead):
		return "dead"
	
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
	return super(delta)
