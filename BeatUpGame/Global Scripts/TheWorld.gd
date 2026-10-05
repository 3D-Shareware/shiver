extends Node


func theWorld(duration: float = 0.1):
	get_tree().paused = true
	var timer = get_tree().create_timer(duration, true, false, true)
	await timer.timeout
	get_tree().paused = false
