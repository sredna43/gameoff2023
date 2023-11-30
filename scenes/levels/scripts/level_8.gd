extends Level

@onready var removable_platform1 = $RemovablePlatform
@onready var removable_platform2 = $RemovablePlatform2
@onready var player_gate1 = $PlayerGate


func _on_button_pressed() -> void:
	removable_platform1.disappear()


func _on_gate_button_1_pressed() -> void:
	player_gate1.disappear()


func _on_button_2_pressed() -> void:
	removable_platform2.disappear()
