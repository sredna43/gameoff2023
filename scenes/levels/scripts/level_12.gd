extends Level

@onready var gate1 = $PlayerGate
@onready var button1 = $Button

@onready var gate2 = $PlayerGate2
@onready var button2 = $Button2

@onready var gate3 = $PlayerGate3
@onready var button3 = $Button3

@onready var gate4 = $PlayerGate4
@onready var button4 = $Button4

@onready var gate5 = $PlayerGate5
@onready var button5 = $Button5

@onready var gate6 = $PlayerGate6


func _on_button_pressed() -> void:
	if (gate1.player_target == 1):
		gate1.player_target = 2
	else:
		gate1.player_target = 1


func _on_button_2_pressed() -> void:
	if (gate2.player_target == 1):
		gate2.player_target = 2
	else:
		gate2.player_target = 1


func _on_button_3_pressed() -> void:
	if (gate3.player_target == 1):
		gate3.player_target = 2
	else:
		gate3.player_target = 1


func _on_button_4_pressed() -> void:
	if (gate4.player_target == 1):
		gate4.player_target = 2
	else:
		gate4.player_target = 1


func _on_button_5_pressed() -> void:
	if (gate5.player_target == 1):
		gate5.player_target = 2
	else:
		gate5.player_target = 1


func _on_button_6_pressed() -> void:
	if (gate6.player_target == 1):
		gate6.player_target = 2
	else:
		gate6.player_target = 1
