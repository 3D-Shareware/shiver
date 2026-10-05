extends RigidBody2D
@export var minimumDamageSpeed: float = 900.0
@export var damage: int

@onready var guy = $"../../Vamp/Guy/Area2D"
@onready var hitbox: Area2D = $Area2D
@onready var health = $"../../Vamp/Guy/Health"
@onready var tip = $Marker2D
@onready var diffi = GameManager.difficulty_manager.current_difficulty

var speed: float = 0.0
var lastTipPosition: Vector2 = Vector2.ZERO

func _ready() -> void:
	if diffi < 0.35:
		damage = 20
	elif diffi >= 0.35 and diffi < 0.75:
		damage = 12
	elif diffi >= 0.75:
		damage = 8
	lastTipPosition = tip.global_position
	guy.body_entered.connect(on_hit)
	guy.area_entered.connect(on_hit)
	
	
func _physics_process(delta: float) -> void:
	var thePosition = tip.global_position
	speed = (thePosition - lastTipPosition).length() / delta
	lastTipPosition = thePosition
	
func on_hit(_guy):
	if speed > minimumDamageSpeed:
		health.takeDamage(damage)
	else:
		pass
	
	
	
	



	
