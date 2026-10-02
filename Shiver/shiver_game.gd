extends MicroGame

@onready var log_placer = $"Log Placer"

func _ready() -> void:
	GameManager.get_node("Background").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	log_placer.start(self)


func _on_respawner_body_entered(body: Node3D) -> void:
	body.position.y = 20
