extends Level

@onready var removable_platform = $RemovablePlatform
@onready var block = $Block

func _on_button_pressed():
	removable_platform.disappear()


func restart() -> void:
	removable_platform.reset()
	block.set_global_position(Vector2(608, 304))
	super()
