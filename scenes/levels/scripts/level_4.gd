extends Level

@onready var removable_platform = $RemovablePlatform
@onready var removable_platform_2 = $RemovablePlatform2

func _on_button_pressed() -> void:
	removable_platform.disappear()


func _on_button_2_pressed() -> void:
	removable_platform_2.disappear()
