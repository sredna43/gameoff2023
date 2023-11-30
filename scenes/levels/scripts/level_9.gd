extends Level


@onready var gate_group1 = $GateGroup1
@onready var gate_group2 = $GateGroup2

@onready var flip_gate = $FlipGate


var active_group = 1

func _ready() -> void:
	for gate in gate_group1.get_children():
		assert(gate is PlayerGate, "All children of GateGroup1 must be PlayerGates")
	for gate in gate_group2.get_children():
		assert(gate is PlayerGate, "All children of GateGroup2 must be PlayerGates")
	_initial_gates()
	super()


func _on_button_pressed() -> void:
	_flip_gates()


func _flip_gates() -> void:
	if (active_group == 1):
		active_group = 2
		for gate in gate_group1.get_children():
			gate.disappear()
		for gate in gate_group2.get_children():
			gate.reset()
	elif (active_group == 2):
		active_group = 1
		for gate in gate_group1.get_children():
			gate.reset()
		for gate in gate_group2.get_children():
			gate.disappear()
	if (flip_gate.player_target == 1):
		flip_gate.player_target = 2
	else:
		flip_gate.player_target = 1

func _initial_gates() -> void:
	for gate in gate_group1.get_children():
		gate.reset()
	for gate in gate_group2.get_children():
		gate.gate.hide()
		gate.disappear()


func restart() -> void:
	super()
	_initial_gates()
