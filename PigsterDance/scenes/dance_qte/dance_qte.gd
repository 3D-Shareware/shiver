class_name DanceQte
extends Node2D

# Emitted when key is pressed and checks whether it can be considered a success
signal key_was_pressed(binding: InputEvent, qte_success: bool)
signal qte_won
signal qte_failed

@export var spawn_offset: float = 64.0

@onready var hit_box: Area2D = $HitBox
@onready var key_handler: Node2D = $KeyHandler
@onready var result_label: Label = $ResultLabel
@onready var spawn_timer = $SpawnTimer

var remaining_keys: Array[InputEvent] = []
var tries_left: int = 0
var is_qte_active: bool = false
var current_level_stats: DanceLevelStats


func _ready() -> void:
	hit_box.area_entered.connect(_on_hit_box_area_entered)
	hit_box.area_exited.connect(_on_hit_box_area_exited)
	
	_qte_debug("Waiting For Input")


func start_qte() -> void:
	if current_level_stats.key_pool.is_empty():
		push_error("Key Pool is Empty")
		return
	
	tries_left = current_level_stats.max_tries
	_start_round()

func _start_round() -> void:
	remaining_keys.assign(current_level_stats.key_pool)
	remaining_keys.shuffle()
	is_qte_active = true
	_qte_debug("Waiting For Input")
	start_spawn_timer()


func start_spawn_timer() -> void:
	spawn_timer.start(1)


func _on_spawn_timer_timeout() -> void:
	_spawn_key()
	if remaining_keys.is_empty():
		stop_spawn_timer()
	else:
		start_spawn_timer()

func stop_spawn_timer() -> void:
	spawn_timer.stop()


func _spawn_key() -> void:
	if remaining_keys.is_empty():
		return
	if current_level_stats.key_visuals == null:
		push_error("Key Scene is empty")
		return
	
	var key: QteKey = current_level_stats.key_visuals.instantiate()
	key_handler.add_child(key)
	key.global_position = Vector2(get_viewport_rect().end.x + spawn_offset, hit_box.global_position.y)
	key.set_key(remaining_keys.pop_front(), current_level_stats.key_speed)
	key.key_press_finished.connect(_on_key_press_finished)

func _on_key_press_finished(key: QteKey, success: bool) -> void:
	if not is_qte_active:
		return
	if not success:
		_fail_qte(key.key, "TOO LATE!")
		return
	
	key_was_pressed.emit(key.key, true)
	_qte_debug("SUCCESS")
	
	if remaining_keys.is_empty() and not _has_pending_keys():
		_end_qte()
		qte_won.emit()



func _input(event: InputEvent) -> void:
	if not is_qte_active or not event.is_pressed() or event.is_echo():
		return
	
	_handle_input(event)


func _handle_input(event: InputEvent) -> void:
	var closest_key := _find_closest_key()
	
	if closest_key == null:
		return
	
	if not closest_key.is_key_in_box:
		_fail_qte(closest_key.key, "TOO EARLY!")
	elif closest_key.is_key_matching(event):
		closest_key.success_state()


func _find_closest_key() -> QteKey:
	var closest_key: QteKey = null
	
	for child in key_handler.get_children():
		var key: QteKey = child
		
		if key == null or not key.is_state_pending() or not key.is_on_screen():
			continue
		if closest_key == null or key.global_position.x < closest_key.global_position.x:
			closest_key = key
	return closest_key


func _on_hit_box_area_entered(area: Area2D) -> void:
	var key: QteKey = area.get_parent()
	if key != null:
		key.is_key_in_box = true

func _on_hit_box_area_exited(area: Area2D) -> void:
	if not is_qte_active:
		return
	
	var key: QteKey = area.get_parent()
	if key == null:
		return
	key.is_key_in_box = false
	if key.is_state_pending():
		key.fail_state()


func _qte_debug(text: String) -> void:
	result_label.text = text

func _has_pending_keys() -> bool:
	for child in key_handler.get_children():
		var key: QteKey = child
		if key != null and key.is_state_pending():
			return true
	return false


func _end_qte() -> void:
	is_qte_active = false
	stop_spawn_timer()


func _clear_keys() -> void:
	for child in key_handler.get_children():
		child.queue_free()

func _fail_qte(failed_key: InputEvent, reason: String) -> void:
	_end_qte()
	_clear_keys()
	tries_left -= 1
	key_was_pressed.emit(failed_key, false)
	
	if tries_left <= 0:
		_qte_debug("%s - No tries left" % reason)
		qte_failed.emit()
		return
	
	_qte_debug("%s - %d tries left" % [reason, tries_left])
	await get_tree().create_timer(current_level_stats.retry_delay).timeout
	_start_round()
