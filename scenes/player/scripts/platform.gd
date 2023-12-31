extends PlayerState

func enter() -> void:
	if (Globals.play_sounds):
		player.platform_sound.play(0.0)
	player.is_platform = true
	player.collision_layer = player.player_num * 8
	player.sprite.scale = Vector2(2, 2)
	player.collision.scale = Vector2(2, 2)

func run(delta: float) -> String:
	player.velocity = Vector2.ZERO
	if (Input.is_action_just_released("p%d_platform" % player.player_num)):
		player.is_platform = false
		player.collision_layer = player.player_num * 2
		player.sprite.scale = Vector2(1, 1)
		player.collision.scale = Vector2(1, 1)
		return "idle"
	if (player.dead):
		return "dead"
	return super(delta)
