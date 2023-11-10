extends State
class_name PlayerState

var player: Player
var input: float = 0.0

func _ready() -> void:
	await(owner.ready)
	player = owner as Player
	assert(player != null)
	super()

func _physics_process(_delta: float) -> void:
	input = Input.get_action_strength("p%d_right" % player.player_num) - Input.get_action_strength("p%d_left" % player.player_num)
