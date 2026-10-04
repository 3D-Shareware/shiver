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
	print($Label.size)
	$Timer.wait_time = time_left
	$Timer.start()
	print("time_left = ", time_left)
	print("Difficulty: ", difficulty)
	var baby1 = baby.instantiate()
	var window1 = window.instantiate()
	level1.add_child(baby1)
	level1.add_child(window1)
	window1.win2.connect(_on_win_2)
	#Position of baby will line up with player controller eventaully
	baby1.position.x = 800; baby1.position.y = 350
	window1.position.x = 1100; window1.position.y = randi_range(145, 503)
	window1.scale.y = randf_range(0.3,0.6)

func _process(_delta):
	if $Timer.start:
		$Label.text = str($Timer.get_time_left()).pad_decimals(2)

func _on_timer_timeout() -> void:
	print("timed out!")
	if win:
		pass
	else:
		print("You lost!")
		#GameManager.lose()

func _on_win_2():
	print("You won!")
	win = true
