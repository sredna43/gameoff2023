extends PlayerState

func enter() -> void:
	player.velocity.y = -player.wall_jump_strength
	super()

func run(_delta: float) -> String:
	return "air"
