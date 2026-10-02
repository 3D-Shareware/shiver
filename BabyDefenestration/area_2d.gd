extends Area2D

signal win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: PhysicsBody2D) -> void:
	if body == RigidBody2D:
		print("body entered")
		win.emit()
		GameManager.win()
	else:
		print("not rigid body")
	
