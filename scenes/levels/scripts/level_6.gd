extends Level

@onready var removable_platform1 = $RemovablePlatform
@onready var removable_platform2 = $RemovablePlatform2
@onready var gate1 = $PlayerGate
@onready var gate2 = $PlayerGate2


func _on_button_pressed() -> void:
	removable_platform1.disappear()


func _on_button_2_pressed() -> void:
	removable_platform2.disappear()


func _on_gate_button_pressed() -> void:
	gate1.disappear()


func _on_gate_button_2_pressed() -> void:
	gate2.disappear()
