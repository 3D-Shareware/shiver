extends RigidBody2D

var vel = linear_velocity
var damp: float = 0.1
var speed: int = 1000
var pressed = false
signal lose

func _ready() -> void:
	self.freeze = true
	gravity_scale = 5.0
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and not pressed:
		print("You threw the baby!")
		pressed = true
		self.freeze = false
		apply_impulse(speed*(Vector2(1,0)))
		await get_tree().create_timer(2.0).timeout
		lose.emit()
		# ^ Vector should be unit vector of arrow
