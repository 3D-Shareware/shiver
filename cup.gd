extends  CharacterBody2D

@export var speed_modifier = 15.0

func _physics_process(delta: float): 
	position = get_global_mouse_position()
	

	
