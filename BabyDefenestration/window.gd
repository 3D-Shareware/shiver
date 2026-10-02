extends Node2D

var dir: int = 1
signal win2

func _ready() -> void:
	position = Vector2(0, 324)
	$Window_Area.win.connect(_on_win)

func _process(_delta: float) -> void: #0.2 -> 6 units (6*8 = 48 pixels); 0.6 -> 18 units
	$".".position.y += 3 * dir
	if $".".position.y >= 648 - (scale.y*30*8): #max = 648
		#print("Hit bottom of screen")
		dir *= -1
		#print("direction changed!")
	elif $".".position.y <= scale.y*30*8: #min = 0
		#print("Hit top of screen")
		dir *= -1
		#print("direction changed!")

func _on_win():
	print("Signal on window1 received")
	win2.emit()
