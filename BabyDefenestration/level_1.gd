extends MicroGame

@onready var level1: Node = $"."
var baby = preload("res://BabyDefenestration/rigidbaby.tscn")
var window = preload("res://BabyDefenestration/window.tscn")

func _ready() -> void:
	var baby1 = baby.instantiate()
	var window1 = window.instantiate()
	level1.add_child(baby1)
	level1.add_child(window1)
	#Position of baby will line up with player controller eventaully
	baby1.position.x = 300; baby1.position.y = 350
	window1.position.x = 1100; window1.position.y = randi_range(150, 550)
	window1.scale.y = randf_range(0.2,0.7)
	print("scale: ", window1.scale.y, " position: ", window1.position)
	
func _process(delta: float) -> void:
	pass
	
