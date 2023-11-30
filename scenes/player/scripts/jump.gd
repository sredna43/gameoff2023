extends PlayerState

func enter() -> void:
	player.velocity.y = -player.jump_strength
	if (Globals.play_sounds):
		player.jump_sound.play(0.0)
	super()

func run(_delta: float) -> String:
	return "air"
