extends Level

@onready var removable_platform1 = $RemovablePlatform
@onready var removable_platform2 = $RemovablePlatform2
@onready var flip_gates = $FlipGates
@onready var gate3 = $PlayerGate3


func _ready() -> void:
	for gate in flip_gates.get_children():
		assert(gate is PlayerGate, "Every child of FlipGates must be a PlayerGate")
	super()


func _on_button_pressed() -> void:
	removable_platform1.disappear()


func _on_button_2_pressed() -> void:
	for gate in flip_gates.get_children():
		if (gate.player_target == 1):
			gate.player_target = 2
		else:
			gate.player_target = 1


func _on_button_4_pressed() -> void:
	removable_platform2.disappear()


func _on_button_5_pressed() -> void:
	gate3.disappear()
