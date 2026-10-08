extends Node2D


func _ready() -> void:
	if GameManager.difficulty_manager.current_difficulty <= 0.75:
		queue_free()
	else:
		return
