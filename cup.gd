extends RigidBody2D

@export var speed_modifier = 15.0

func _physics_process(delta: float) -> void:
	var target_pos = get_global_mouse_position()
	
	var travel_vector = target_pos - global_position
	
	linear_velocity = travel_vector * speed_modifier
