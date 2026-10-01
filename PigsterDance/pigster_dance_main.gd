extends Node2D

@onready var level_animation_player = %LevelAnimationPlayer
@onready var label_timer = $LabelTimer
@onready var start_text = $StageUI/StartText
@onready var qte_handler = $QteHandler
@onready var dance_qte = $QteHandler/DanceQte


signal stage_set

# Called when the node enters the scene tree for the first time.
func _ready():
	stage_set.connect(_start_game)
	dance_qte.qte_won.connect(_on_dance_qte_won)
	dance_qte.qte_failed.connect(_on_dance_qte_failed)
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
	stage_set.emit()

func _start_game() -> void:
	dance_qte.start_qte()


func _on_dance_qte_won() -> void:
	_show_result_text("qte won")


func _on_dance_qte_failed() -> void:
	_show_result_text("qte dance failed")


func _show_result_text(text: String) -> void:
	start_text.text = text
	start_text.show()
