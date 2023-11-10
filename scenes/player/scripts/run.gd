extends PlayerState

func run(delta: float) -> String:
	if (input == 0):
		return "idle"
	if (Input.is_action_pressed("p%d_jump" % player.player_num)):
		return "jump"
	if (Input.is_action_pressed("p%d_platform" % player.player_num) and player.can_become_platform):
		return "platform"
	if (!player.is_on_floor()):
		return "air"
	if (player.going_to_goal):
		return "in_goal"
	if (player.dead):
		return "dead"
	
	player.velocity.x += (input - player.on_wall) * player.speed
	player.velocity.x = clamp(player.velocity.x, -player.max_speed, player.max_speed)
	return super(delta)
