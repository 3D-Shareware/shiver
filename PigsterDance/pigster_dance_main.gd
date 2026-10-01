extends Node2D

@onready var level_animation_player = %LevelAnimationPlayer
@onready var label_timer = $LabelTimer
@onready var start_text = $StageUI/StartText



# Called when the node enters the scene tree for the first time.
func _ready():
	_set_the_stage()


# Plays the animation at the start of the level
func _set_the_stage() -> void:
	level_animation_player.play("level_start")
	_show_start_text()


func _show_start_text() -> void:
	await level_animation_player.animation_finished
	label_timer.start(0.7)
	await label_timer.timeout
	start_text.show()
	label_timer.start(0.7)
	await label_timer.timeout
	start_text.hide()

func _show_qte() -> void:
	pass
