extends MicroGame

func _ready() -> void:
	GameManager.get_node("Background").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
