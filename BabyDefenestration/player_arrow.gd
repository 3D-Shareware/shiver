extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var move_direction : String = "left"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scale.x <= 0.5:
		move_direction = "right"
	if scale.x >= 1.0:
		move_direction = "left"
	if move_direction == "left":
		scale.x -= 0.02
	elif move_direction == "right":
		scale.x += 0.02
