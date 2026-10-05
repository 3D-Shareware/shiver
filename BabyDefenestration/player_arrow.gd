extends Polygon2D

var rotationSpeed : float = 0.05
var launchSpeed : float = 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var move_direction : String = "left"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_launch_angle()

func _launch_angle() -> void:
	if rotation <= 0.0:
		move_direction = 'right'
	if rotation >= 5.0:
		move_direction = 'left'
	if move_direction == 'right':
		rotation += rotationSpeed
	if move_direction == 'left':
		rotation -= rotationSpeed

func _launch() -> void:
	if scale.x <= 0.5:
		move_direction = "right"
	if scale.x >= 1.0:
		move_direction = "left"
	if move_direction == "left":
		scale.x -= launchSpeed
	elif move_direction == "right":
		scale.x += launchSpeed
