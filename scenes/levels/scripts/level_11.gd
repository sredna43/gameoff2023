extends Level

@onready var flip_gates = $FlipGates
@onready var removable_platform = $RemovablePlatform
@onready var removable_platform2 = $RemovablePlatform2
@onready var removable_platform3 = $RemovablePlatform3


func _ready() -> void:
	for gate in flip_gates.get_children():
		assert(gate is PlayerGate, "All children of FlipGates must be PlayerGate")
	super()


func _flip_gates() -> void:
	for gate in flip_gates.get_children():
		if (gate.player_target == 1):
			gate.player_target = 2
		elif (gate.player_target == 2):
			gate.player_target = 1


func _on_button_4_pressed() -> void:
	removable_platform.disappear()
	removable_platform2.disappear()


func _on_button_5_pressed() -> void:
	removable_platform3.disappear()
