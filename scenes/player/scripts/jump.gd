extends PlayerState

func enter() -> void:
	player.velocity.y = -player.jump_strength
	super()

func run(_delta: float) -> String:
	return "air"
