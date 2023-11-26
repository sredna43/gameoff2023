extends Level

@onready var removable_platform1 = $RemovablePlatform
@onready var removable_platform2 = $RemovablePlatform2
@onready var gate1 = $PlayerGate
@onready var gate2 = $PlayerGate2
@onready var block1 = $Block
@onready var block2 = $Block2


func _on_button_pressed() -> void:
	removable_platform1.disappear()


func _on_button_2_pressed() -> void:
	removable_platform2.disappear()


func _on_gate_button_pressed() -> void:
	gate1.disappear()


func _on_gate_button_2_pressed() -> void:
	gate2.disappear()


func restart() -> void:
	gate1.reset()
	gate2.reset()
	removable_platform1.reset()
	removable_platform2.reset()
	block1.set_global_position(Vector2(960, 144))
	block2.set_global_position(Vector2(-1680, -24))
	super()
