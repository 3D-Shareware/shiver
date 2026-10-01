extends CharacterBody3D

@onready var camera_pivot = $"Camera Pivot"
@onready var camera = $"Camera Pivot/Camera3D"

var game: Node3D

const MOUSE_SENSITIVITY = 0.0025

const GRAV = -40.0
const GROUND_ACCEL = 60.0
const MAX_SPEED = 10.0

# the number of projects I have made where the y velocity is overriden manually every frame is truly ridiculous
var current_grav = 0.0

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var camera_movement: Vector2
		camera_movement = event.screen_relative * -MOUSE_SENSITIVITY
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x + camera_movement.y, -PI / 2, PI / 2)
		camera_pivot.rotate_y(camera_movement.x)

func _ready() -> void:
	game = get_parent()

func _physics_process(delta: float) -> void:
	# *** Camera movement ***
	var cam_rot = camera_pivot.global_rotation.y
	
	# *** Jumping and gravity ***
	if is_on_floor():
		current_grav = 0.0
	elif is_on_ceiling() and current_grav > 0:
		current_grav = 0
	else:
		current_grav += GRAV * delta
	
	# *** Horizontal movement ***
	var raw_input_dir = Input.get_vector("a", "d", "s", "w")
	
	# modified by raw_input based on camera rotation
	var cooked_input_dir = Vector3.ZERO
	
	# forward and back
	cooked_input_dir.z -= raw_input_dir.y * cos(cam_rot)
	cooked_input_dir.x -= raw_input_dir.y * sin(cam_rot)
	# left and right
	cooked_input_dir.z -= raw_input_dir.x * sin(cam_rot)
	cooked_input_dir.x += raw_input_dir.x * cos(cam_rot)
	
	velocity = velocity.move_toward(cooked_input_dir * MAX_SPEED, GROUND_ACCEL * delta)
	velocity.y = current_grav
	
	move_and_slide()
