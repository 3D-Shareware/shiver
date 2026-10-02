extends Node2D

var dir: int = 1

func _ready() -> void:
	position.y = randi_range(-500, 500)
	var window_size: Vector2 = get_viewport().get_visible_rect().size
	print("window size: ", window_size)

func _process(delta: float) -> void:
	$".".position.y += 3 * dir
	if $".".position.y == 648:
		dir *= -1
		print("direction changed!")
	elif $".".position.y == 0:
		dir *= -1
		print("direction changed!")
