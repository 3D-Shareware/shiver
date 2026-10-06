extends Polygon2D

#GameManager.difficulty_manager.current_difficulty
#var difficulty1 = GameManager.difficulty_manager.current_difficulty
var rotationSpeed : float = 2.0 #+ difficulty1
var launchSpeed : float = 0.02 #+ difficulty1*.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var move_direction : String = "left"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _launch_angle() -> void:
	if rotation_degrees >= 45.0:
		move_direction = 'left'
	if rotation_degrees <= -45.0:
		move_direction = 'right'
	if move_direction == 'left':
		rotation_degrees -= rotationSpeed
	if move_direction == 'right':
		rotation_degrees += rotationSpeed

func _launch() -> void:
	if scale.x <= 0.5:
		move_direction = "right"
	if scale.x >= 1.0:
		move_direction = "left"
	if move_direction == "left":
		scale.x -= launchSpeed
	elif move_direction == "right":
		scale.x += launchSpeed
