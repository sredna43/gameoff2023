extends PlayerState

func enter() -> void:
	player.collision.disabled = true
	player.velocity.y = -player.jump_strength
	player.sprite.scale = Vector2(1, 1)
	player.collision.scale = Vector2(1, 1)

func run(delta: float) -> String:
	if (!player.dead):
		return "idle"
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
	player.velocity.y += player.gravity
	return super(delta)

func exit() -> void:
	player.collision.disabled = false
	player.collision_layer = 2
	player.is_platform = false
	player.expand_icon.visible = true
	player.animation_player.queue("respawn")
