extends Node2D

# @onready var difficulty_manager

#var EasyLayouts : Array[PackedScene] = [
#	preload("res://BridgeBuilder/map/EasyMaps/EasyFrowns.tscn"),
#	preload("res://BridgeBuilder/map/EasyMaps/EasyOval.tscn"),
#	preload("res://BridgeBuilder/map/EasyMaps/EasyPyramid.tscn"),
#	preload("res://BridgeBuilder/map/EasyMaps/EasySmiles.tscn"),
#	preload("res://BridgeBuilder/map/EasyMaps/EasyThreeBlocks.tscn")
#]

#var MedLayouts : Array[PackedScene] = [
#	preload("res://BridgeBuilder/map/MediumMaps/MediumArrows.tscn"),
#	preload("res://BridgeBuilder/map/MediumMaps/MediumRamp.tscn"),
#	preload("res://BridgeBuilder/map/MediumMaps/MediumSpike.tscn"),
#	preload("res://BridgeBuilder/map/MediumMaps/MediumSpikesPlural.tscn")
#]

#var HardLayouts : Array[PackedScene] = [
#	preload("res://BridgeBuilder/map/HardMaps/HardHolesInWall.tscn"),
#	preload("res://BridgeBuilder/map/HardMaps/HardThroughTheSphere.tscn"),
#	preload("res://BridgeBuilder/map/HardMaps/HardWallOne.tscn")
#]

var layouts : Array[PackedScene] = [
	preload("res://BridgeBuilder/map/EasyMaps/EasyFrowns.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasyOval.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasyPyramid.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasySmiles.tscn"),
	preload("res://BridgeBuilder/map/EasyMaps/EasyThreeBlocks.tscn"),
	preload("res://BridgeBuilder/map/MediumMaps/MediumArrows.tscn"),
	preload("res://BridgeBuilder/map/MediumMaps/MediumRamp.tscn"),
	preload("res://BridgeBuilder/map/MediumMaps/MediumSpike.tscn"),
	preload("res://BridgeBuilder/map/MediumMaps/MediumSpikesPlural.tscn"),
	preload("res://BridgeBuilder/map/HardMaps/HardHolesInWall.tscn"),
	preload("res://BridgeBuilder/map/HardMaps/HardThroughTheSphere.tscn"),
	preload("res://BridgeBuilder/map/HardMaps/HardWallOne.tscn")
]

func _ready() -> void:
	spawn_scene()
	
func spawn_scene() -> void:
	var scene_to_spawn : PackedScene = layouts.pick_random()
	var instance = scene_to_spawn.instantiate()
	add_child(instance)
