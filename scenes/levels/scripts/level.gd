extends Node2D
class_name Level

signal won

@export var next_level: String = "-1"

@onready var player1: Player = $Player1
@onready var player2: Player = $Player2
@onready var cam = $MultitargetCamera

var has_won = false


func _ready() -> void:
	cam.add_target(player1)
	cam.add_target(player2)
	process_mode = Node.PROCESS_MODE_PAUSABLE


func _check_win_level():
	if (player1.in_goal and player2.in_goal and not has_won):
		print("level won")
		has_won = true
		emit_signal("won")


func _physics_process(_delta: float) -> void:
	_check_win_level()


func restart() -> void:
	player1.respawn()
	player2.respawn()
