extends TextureProgressBar

var value_ticker : float = 1
var timer_slowdown_strength : int = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value_ticker -= delta / timer_slowdown_strength
	value = value_ticker
	tint_progress = Color(1-value_ticker,1-value_ticker,1,1)
