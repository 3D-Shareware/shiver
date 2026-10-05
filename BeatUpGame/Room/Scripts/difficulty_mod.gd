extends RigidBody2D

@onready var diffi = GameManager.difficulty_manager.current_difficulty

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	physics_material_override.bounce = 0.41 + diffi
	physics_material_override.friction = 1 - diffi
	if physics_material_override.bounce > 1:
		physics_material_override.bounce = 1
	if physics_material_override.friction < 0:
		physics_material_override.friction = 0
	
	
