class_name QteLine
extends Node2D

# Emitted when key is pressed and checks whether it can be considered a success
signal key_was_pressed(binding: InputEvent, qte_success: bool)

@export var key_scene: PackedScene
@export var key_pool: Array[InputEvent] = []
@export var key_speed: float = 350.0
@export var is_in_debug: bool = true

@export_group("Spawning Data")
@export var spawn_offset: float = 64.0

@onready var hit_box: Area2D = $HitBox
@onready var key_handler: Node2D = $KeyHandler
@onready var result_label: Label = $ResultLabel
@onready var spawn_timer = $SpawnTimer


func _ready() -> void:
	hit_box.area_entered.connect(_on_hit_box_area_entered)
	hit_box.area_exited.connect(_on_hit_box_area_exited)
	
	_qte_debug("Waiting For Input")
	if is_in_debug:
		start_spawn_timer()


func _input(event: InputEvent) -> void:
	if not event.is_pressed() or event.is_echo():
		return
	
	_handle_input(event)


func start_spawn_timer() -> void:
	spawn_timer.start(1)


func stop_spawn_timer() -> void:
	spawn_timer.stop()


func _on_spawn_timer_timeout() -> void:
	_spawn_key()
	start_spawn_timer()


func _spawn_key() -> void:
	if key_pool.is_empty():
		push_error("Key Pool is empty in Inspector")
		return
	
	if key_scene == null:
		push_error("Key Scene is empty in Inspector")
		return
	
	var key: QteKey = key_scene.instantiate()
	key_handler.add_child(key)
	key.global_position = Vector2(get_viewport_rect().end.x + spawn_offset, hit_box.global_position.y)
	key.set_key(key_pool.pick_random(), key_speed)
	key.key_press_finished.connect(_on_key_press_finished)


func _handle_input(event: InputEvent) -> void:
	var closest_key = _find_closest_key(event)
	
	if closest_key == null:
		return
	
	if closest_key.is_key_in_box:
		closest_key.success_state()
	else:
		_qte_debug("TOO EARLY!")
		key_was_pressed.emit(closest_key.key)



func _find_closest_key(event: InputEvent) -> QteKey:
	var closest_key: QteKey = null
	
	for child in key_handler.get_children():
		var key := child as QteKey
		
		if key == null or not key.is_state_pending() or not key.is_on_screen():
			continue
		if not key.is_key_matching(event):
			continue
		if closest_key == null or key.global_position.x < closest_key.global_position.x:
			closest_key = key
	return closest_key


func _on_hit_box_area_entered(area: Area2D) -> void:
	var key := area.get_parent() as QteKey
	if key != null:
		key.is_key_in_box = true


func _on_hit_box_area_exited(area: Area2D) -> void:
	var key := area.get_parent() as QteKey
	if key == null:
		return
	key.is_key_in_box = false
	# Left the box without being pressed = too late.
	if key.is_state_pending():
		key.fail_state()


func _on_key_press_finished(key: QteKey, success: bool) -> void:
	if success:
		_qte_debug("SUCCESS")
	else:
		_qte_debug("FAIL")
	key_was_pressed.emit(key.key, success)


func _qte_debug(text: String) -> void:
	result_label.text = text
