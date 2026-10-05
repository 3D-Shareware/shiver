extends Node3D

@onready var game = get_parent()

const TREE = preload("res://Shiver/objects/tree.tscn")
## More trees means harder level.
var tree_count = 100
const TREE_MIN_RANGE = 3
const TREE_MAX_RANGE = 36

func start(the_game: Node) -> void:
	game = the_game
	for i in tree_count:
		var new_tree = TREE.instantiate()# as RigidBody3D
		game.add_child(new_tree)
		new_tree.position = Vector3(((randi_range(1, 2) * 2) - 3) * randf_range(TREE_MIN_RANGE, TREE_MAX_RANGE), randf_range(-5, -1), ((randi_range(1, 2) * 2) - 3) * randf_range(TREE_MIN_RANGE, TREE_MAX_RANGE))
		#new_tree.apply_impulse(Vector3(0, -10, 0))
