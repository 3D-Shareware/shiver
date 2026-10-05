extends AnimatedSprite2D

@onready var guySprite = $"."

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = $"../Guy".global_position
