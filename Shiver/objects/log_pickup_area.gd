extends Area3D

var all_bodies_inside_me: Array[RigidBody3D] = []

func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		all_bodies_inside_me.append(body)

func _on_body_exited(body: Node3D) -> void:
	if body is RigidBody3D and all_bodies_inside_me.has(body):
		all_bodies_inside_me.pop_at(all_bodies_inside_me.find(body))
