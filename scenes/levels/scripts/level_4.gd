extends Level

@onready var removable_platform = $RemovablePlatform
@onready var removable_platform_2 = $RemovablePlatform2
@onready var block1 = $Block
@onready var block2 = $Block2
@onready var block3 = $Block3


func _on_button_pressed() -> void:
	removable_platform.disappear()


func _on_button_2_pressed() -> void:
	removable_platform_2.disappear()


func restart() -> void:
	removable_platform.reset()
	removable_platform_2.reset()
	block1.set_global_position(Vector2(752, 512))
	block2.set_global_position(Vector2(752, 144))
	block3.set_global_position(Vector2(880, 144))
	super()
