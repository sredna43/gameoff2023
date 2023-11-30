extends AnimatableBody2D

@export var from: Marker2D
@export var to: Marker2D
@export var duration = 5.0

func _ready():
	assert(not from == null, "Assign Marker2D to 'From'")
	assert(not to == null, "Assign Marker2D to 'To'")
	start_tween()

func start_tween():
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", to.global_position, duration / 2)
	tween.tween_property(self, "position", from.global_position, duration / 2)
