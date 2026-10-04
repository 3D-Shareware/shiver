extends CharacterBody3D

@onready var light = $"OmniLight3D"
@onready var burst_particles = $"BurstParticles"

const GRAVITY = -10.0

var temp: float = 1.0
## When 0.1, takes 10 seconds to fully deplete temperature.
var temp_loss_multiplier: float = 0.1

const MAX_RANGE = 200.0
const MAX_ENERGY = 15.0

const ENERGY_FROM_FIREWOOD = 0.5

signal fire_gone_out

func _process(delta: float) -> void:
	temp = move_toward(temp, 0, delta * temp_loss_multiplier)
	light.omni_range = MAX_RANGE * temp
	light.light_energy = MAX_ENERGY * temp
	
	if temp <= 0:
		fire_gone_out.emit()

func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY
	else:
		velocity.y = 0
	move_and_slide()

## Eat the log.
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		burst_particles.emitting = true
		body.queue_free()
		temp = clamp(temp + ENERGY_FROM_FIREWOOD, 0, 1)
