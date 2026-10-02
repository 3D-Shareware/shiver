extends Node2D

var dir: int = 1

func _ready() -> void:
	position = Vector2(0, 324)
	var window_size: Vector2 = get_viewport().get_visible_rect().size
	print("window size: ", window_size)

func _process(delta: float) -> void: #0.2 -> 6 units (6*8 = 48 pixels); 0.6 -> 18 units
	$".".position.y += 3 * dir
	if $".".position.y >= 648 - (scale.y*30*8): #max = 648
		print("Hit bottom of screen")
		dir *= -1
		print("direction changed!")
	elif $".".position.y <= scale.y*30*8: #min = 0
		print("Hit top of screen")
		dir *= -1
		print("direction changed!")
