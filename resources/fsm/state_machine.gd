extends Node
class_name StateMachine

var states: Dictionary = {}
var current_state: State

var next_state: State
var next_state_tag: String

func init_states() -> void:
	for state in get_children():
		if state.tag:
			states[state.tag] = state

func run(delta: float) -> void:
	next_state_tag = current_state.run(delta)
	if next_state_tag:
		change_state(next_state_tag)

func change_state(next_tag: String) -> void:
	next_state = states.get(next_tag)
	if next_state:
		current_state.exit()
		current_state = next_state
		current_state.enter()

func _ready() -> void:
	init_states()
	current_state = get_child(0)
