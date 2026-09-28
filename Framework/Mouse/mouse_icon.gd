class_name PawMouseIcon extends Node2D

var current_mouse_uid : String = ''
var current_mouse_texture : Texture2D = null

func _ready() -> void:
	# This gives a UID for the mouse image
	current_mouse_uid = ProjectSettings.get_setting("display/mouse_cursor/custom_image") as String
	print(current_mouse_uid)
	current_mouse_texture = load(current_mouse_uid) as Texture2D
	print(current_mouse_texture)
