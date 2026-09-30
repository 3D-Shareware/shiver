extends RigidBody2D

var vel = linear_velocity
var damp: float = 0.1

func _ready() -> void:
	self.freeze = true
	gravity_scale = 5.0
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("You threw the baby!")
		self.freeze = false
		apply_force(Vector2(50000,0))
	vel *= damp*delta
