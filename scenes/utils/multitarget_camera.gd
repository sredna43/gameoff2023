extends Camera2D

@export var move_speed = 30 # camera position lerp speed
@export var zoom_speed = 5.0  # camera zoom lerp speed
@export var min_zoom = 5.0  # camera won't zoom closer than this
@export var max_zoom = 0.75  # camera won't zoom farther than this
@export var margin = Vector2(400, 200)  # include some buffer area around targets

var targets: Array[Player] = []

@onready var screen_size = get_viewport_rect().size

var p
var r
var z

func _process(delta):
	if !targets:
		return

	# Keep the camera centered among all targets
	p = Vector2.ZERO
	for target in targets:
		if (target.dead or target.respawning):
			p += target.respawn_position
		else:
			p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed * delta)

	# Find the zoom that will contain all targets
	r = Rect2(position, Vector2.ONE)
	for target in targets:
		if (target.dead or target.respawning):
			r = r.expand(target.respawn_position)
		else:
			r = r.expand(target.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	if r.size.x > r.size.y * screen_size.aspect():
		z = 1 / clamp(r.size.x / screen_size.x, max_zoom, min_zoom)
	else:
		z = 1 / clamp(r.size.y / screen_size.y, max_zoom, min_zoom)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed * delta)

func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	if t in targets:
		targets.erase(t)
