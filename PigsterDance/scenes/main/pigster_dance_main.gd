class_name PigsterDance
extends MicroGame

@export var difficulty_pools: DanceDifficultyPools
@export var transition_delay: float = 1.0
@export var ragdoll_scene: PackedScene
@export var death_scenes: Array[PackedScene]

@onready var level_animation_player = %LevelAnimationPlayer
@onready var label_timer = $LabelTimer
@onready var qte_handler = $QteHandler
@onready var dance_qte = $QteHandler/DanceQte
@onready var boo_player: AudioStreamPlayer = $BooPlayer
@onready var pigster = $Pigster 

var level_stats: DanceLevelStats
var current_dance: int = 1 
var game_over:bool = false

signal stage_set


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PAUSED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		NOTIFICATION_UNPAUSED:
			if not game_over:
				Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _exit_tree() -> void:
	# Safety net, e.g. if the player quits to the main menu from the pause menu
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	dance_qte.hide()
	stage_set.connect(_start_game)
	dance_qte.qte_won.connect(_on_dance_qte_won)
	dance_qte.qte_failed.connect(_on_dance_qte_failed)
	dance_qte.try_failed.connect(_on_dance_qte_try_failed)
	dance_qte.retry_started.connect(_on_dance_qte_retry_started)
	dance_qte.key_succeeded.connect(_on_key_succeeded)
	_set_difficulty()
	_set_the_stage()

func _set_difficulty() -> void:
	if difficulty <= 0.3:
		level_stats = _set_level_stats(difficulty_pools.easy_pool)
	elif difficulty > 0.3 and difficulty < 0.6:
		level_stats = _set_level_stats(difficulty_pools.medium_pool)
	else:
		level_stats = _set_level_stats(difficulty_pools.hard_pool)
	
	# Send the current level stats to the DanceQte
	dance_qte.current_level_stats = level_stats

func _set_level_stats(difficulty_pool: Array[DanceLevelStats]) -> DanceLevelStats:
	var new_stats = difficulty_pool.pick_random()
	return new_stats

# Plays the animation at the start of the level
func _set_the_stage() -> void:
	level_animation_player.play("level_start")
	
	await level_animation_player.animation_finished
	pigster.play("wake_up")
	await pigster.animation_finished
	stage_set.emit()





func _start_game() -> void:
	dance_qte.show()
	pigster.play("dance_1") 
	await get_tree().create_timer(transition_delay).timeout
	dance_qte.start_qte()


func _on_key_succeeded() -> void:
	_change_dance()


func _change_dance() -> void: 
	print("CHANGING DANCE")
	var next_dance := randi_range(1, 3)
	
	while next_dance == current_dance:
		next_dance = randi_range(1, 3)
	
	current_dance = next_dance
	print("Playing: dance_%d" % current_dance)

	pigster.play("dance_%d" % current_dance)


func _on_dance_qte_won() -> void:
	await get_tree().create_timer(transition_delay).timeout
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameManager.win()


func _on_dance_qte_failed() -> void:
	dance_qte.hide()
	await _play_death()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameManager.lose()
	
func _play_death() -> void:
	pigster.pause()

	if death_scenes.is_empty():
		push_error("Death Scenes is Empty")
		return

	var death: DanceDeath = death_scenes.pick_random().instantiate()
	add_child(death)
	death.impact.connect(_on_death_impact)
	death.start(pigster.global_position)
	await death.finished

func _on_death_impact(hit_position: Vector2, direction: Vector2) -> void:
	var ragdoll: PigsterRagdoll = ragdoll_scene.instantiate()
	add_child(ragdoll)
	ragdoll.global_position = pigster.global_position
	pigster.hide()
	ragdoll.burst(hit_position, direction)



func _on_dance_qte_try_failed() -> void:
	pigster.pause()
	boo_player.play()


func _on_dance_qte_retry_started() -> void:
	pigster.play()

func _on_escape_clicked() -> void:
	pass
