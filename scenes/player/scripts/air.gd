extends PlayerState

func run(delta: float) -> String:
	if (player.is_on_floor()):
		return "idle"
	if (player.on_wall != 0 and abs(input - player.on_wall) < 0.3 and Input.is_action_just_pressed("p%d_jump" % player.player_num)):
		player.velocity.x = -player.on_wall * player.wall_jump_kick
		return "wall_jump"
	if (Input.is_action_pressed("p%d_platform" % player.player_num) and player.can_become_platform):
		return "platform"
	if (player.going_to_goal):
		return "in_goal"
	if (player.dead):
		return "dead"
	
	if (!Input.is_action_pressed("p%d_jump" % player.player_num) and player.velocity.y < 0):
		player.velocity.y = lerp(player.velocity.y, 0.0, player.friction)
	if (player.on_wall != 0 && player.velocity.y > 0 && input == player.on_wall):
		player.velocity.y += player.gravity / 4.0
	else:
		player.velocity.y += player.gravity
		
	player.velocity.x += input * player.speed
	player.velocity.x = lerp(player.velocity.x, 0.0, player.air_resistance)
	player.velocity.x = clamp(player.velocity.x, -(player.max_speed + player.wall_jump_strength), player.max_speed + player.wall_jump_strength)
	player.velocity.y = clamp(player.velocity.y, -player.jump_strength, player.terminal_velocity)
	return super(delta)
