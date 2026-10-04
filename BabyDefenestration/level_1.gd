extends MicroGame

@onready var level1: Node = $"."
@onready var a = 0
var baby = preload("res://BabyDefenestration/rigidbaby.tscn")
var window = preload("res://BabyDefenestration/window.tscn")
var timer_start = false
var time_left = 15 - (10*difficulty)
var win = false

func _ready() -> void:
	$Label.position = Vector2(50, 500)
	$Timer.wait_time = time_left
	$Timer.start()
	
	var baby1 = baby.instantiate()
	var window1 = window.instantiate()
	var babybody = baby1.get_node("RigidBody2D")
	var windowarea = window1.get_node("Window_Area")
	level1.add_child(baby1)
	level1.add_child(window1)
	windowarea.win.connect(_on_win)
	babybody.lose.connect(_on_lose)
	
	baby1.position.x = 800; baby1.position.y = 350
	window1.position.x = 1100; window1.position.y = randi_range(145, 503)
	window1.scale.y = randf_range(0.3,0.6)
	
	print("Difficulty: ", difficulty)

func _process(_delta):
	if $Timer.start:
		$Label.text = str($Timer.get_time_left()).pad_decimals(2)

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
