extends Level

@onready var removable_platform = $RemovablePlatform

func _on_button_pressed():
	removable_platform.disappear()
