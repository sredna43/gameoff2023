extends Level

@onready var p1gate1 = $P1Gate1
@onready var p2gate1 = $P2Gate1
@onready var p1gate2 = $P1Gate2
@onready var p2gate2 = $P2Gate2


func _on_p_1_button_1_pressed() -> void:
	p1gate1.disappear()


func _on_p_2_button_1_pressed() -> void:
	p2gate1.disappear()


func _on_p_1_button_2_pressed() -> void:
	p1gate2.disappear()


func _on_p_2_button_2_pressed() -> void:
	p2gate2.disappear()
