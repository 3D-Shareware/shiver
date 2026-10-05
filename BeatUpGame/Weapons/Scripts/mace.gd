extends Node2D

func _ready() -> void:
	if GameManager.difficulty_manager.current_difficulty > 0.35:
		queue_free()
	else:
		return
