extends Node2D

var timer: float = 20.0
@onready var health = $"../Vamp/Guy/Health"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if health.healthPoints <= 0:
		queue_free()
	if timer > 0:
		$Label.text = str(ceili(timer))
	if timer <= 0:
		if not $Lose.playing:
			$Lose.play()
		await get_tree().create_timer(0.2).timeout
		GameManager.lose()
