extends Node2D

@onready var hitAudioPlayer = $"../Pain"
@onready var guySprite = $"../../GuySprite"
var healthPoints: int = 100
var hitAnimations = ["hurt1", "hurt2", "hurt3", "hurt4", "hurt5", "hurt6", "hurt7", "hurt8", "hurt9"]
var hasBeenHit: bool

func _ready() -> void:
	hasBeenHit = false

func playSoundWin() -> void:
	if hasBeenHit == false:
		$"../../../Win".play()
		

func takeDamage(damage: int) -> void:
	if healthPoints <= 0:
		healthPoints = 0
		die()
		return
	TheWorld.theWorld(0.08)
	$"../Area2D/CPUParticles2D".emitting = true
	$"../AudioStreamPlayer2D".play()
	hitAudioPlayer.play()
	var randomAnim = hitAnimations.pick_random()
	if healthPoints >= 30:
		guySprite.play(randomAnim)
	healthPoints -= damage
	await get_tree().create_timer(0.5).timeout
	if healthPoints >= 70:
		guySprite.play("healthy")
	elif healthPoints <= 70 and healthPoints > 30:
		guySprite.play("injured")
	elif healthPoints <= 30 and healthPoints > 0:
		guySprite.play("badlyinjured")
	
	
	
func die() -> void:
	guySprite.play("dead")
	TheWorld.theWorld(0.08)
	$"../Area2D/CPUParticles2D".emitting = true
	$"../AudioStreamPlayer2D".play()
	$"../Death".play()
	playSoundWin()
	hasBeenHit = true
	await get_tree().create_timer(3).timeout
	GameManager.win()
