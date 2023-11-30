extends PlayerState

func enter() -> void:
	if (Globals.play_sounds):
		player.jump_sound.play(0.0)
	player.velocity.y = -player.wall_jump_strength
	super()

func run(_delta: float) -> String:
	return "air"
