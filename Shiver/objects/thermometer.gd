extends TextureProgressBar

var value_ticker : float = 1

## value of 50 corresponds roughly to needing to survive 50 secs
@export var timer_slowdown_strength : int = 30
signal survived

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value_ticker -= delta / timer_slowdown_strength
	value = value_ticker
	tint_progress = Color(1-value_ticker,1-value_ticker,1,1)
	
	if value_ticker <= min_value:
		survived.emit()
