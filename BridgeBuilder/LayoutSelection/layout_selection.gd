extends Node2D

var easy_layouts : Array[PackedScene] = [
	preload("res://BridgeBuilder/map/EasyMaps/EasyFrowns.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasyOval.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasyPyramid.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasySmiles.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasyThreeBlocks.tscn"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_layout()

func spawn_layout() -> void:
	var random_layout : PackedScene = easy_layouts.pick_random()
	var new_instance = random_layout.instantiate()
	add_child(new_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
