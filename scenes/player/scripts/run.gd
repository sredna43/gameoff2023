extends PlayerState

func run(delta: float) -> String:
	if (input == 0):
		return "idle"
	if (Input.is_action_pressed("p%d_jump" % player.player_num)):
		return "jump"
	if (!player.is_on_floor()):
		return "air"
	player.velocity.x += (input - player.on_wall) * player.speed
	player.velocity.x = clamp(player.velocity.x, -player.max_speed, player.max_speed)
	return super(delta)
