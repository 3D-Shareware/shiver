extends MicroGame

@onready var level1: Node = $"."
@onready var a = 0
var baby = preload("res://BabyDefenestration/rigidbaby.tscn")
var window = preload("res://BabyDefenestration/window.tscn")
var timer_start = false
var time_left = 15 - (10*GameManager.difficulty_manager.current_difficulty)
var win = false
var pressed : bool = false
var pressed2: bool = false
var difficulty1 = difficulty
@onready var label : Label = $/root/Level1/Label
@onready var timer : Timer = $/root/Level1/Timer
@onready var playerArrow: Polygon2D = $/root/Level1/Player
@onready var baby1 = baby.instantiate()
@onready var babybody = baby1.get_node("RigidBody2D")

func _ready() -> void:
	label.position = Vector2(50, 500)
	timer.wait_time = time_left
	timer.start()
	
	#var baby1 = baby.instantiate()
	var window1 = window.instantiate()
	#var babybody = baby1.get_node("RigidBody2D")
	var windowarea = window1.get_node("Window_Area")
	level1.add_child(baby1)
	level1.add_child(window1)
	windowarea.win.connect(_on_win)
	babybody.lose.connect(_on_lose)
	babybody.press.connect(_on_press)
	babybody.press2.connect(_on_press_2)
	
	baby1.position = playerArrow.position
	#baby1.position.x = 800; baby1.position.y = 350
	window1.position.x = 1100; window1.position.y = randi_range(145, 503)
	window1.scale.y = randf_range(0.3,0.6)
	
	print("Difficulty: ", difficulty)

func _process(_delta):
	if timer.start:
		label.text = str(timer.get_time_left()).pad_decimals(2)
	if !pressed:
		playerArrow._launch_angle()
	if pressed and !pressed2:
		playerArrow._launch()
	if pressed2:
		print("rotation: ",playerArrow.rotation, "scale: ", playerArrow.scale)
		babybody.throw(playerArrow.rotation, 5000*playerArrow.scale)
		pressed2 = false
	
func _on_press() -> void:
	pressed = true

func _on_press_2() -> void:
	pressed2 = true

func _on_timer_timeout() -> void:
	print("timed out!")
	if not win:
		print("You lost!")
		GameManager.lose()

func _on_win():
	win = true
	
func _on_lose():
	if win:
		pass
	else:
		GameManager.lose()
