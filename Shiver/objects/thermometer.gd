extends TextureProgressBar

var value_ticker : float = 1
var game_started : bool = false
var win_sequence : bool = false

## value of 50 corresponds roughly to needing to survive 50 secs
@export var timer_slowdown_strength : int = 30
var heatup_time : int = 4
signal survived

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not game_started:
		return
	elif win_sequence:
		value_ticker += delta / heatup_time
		value = value_ticker
		tint_progress = Color(1,1-value_ticker,1-value_ticker,1)
		
		if not animation_player.is_playing():
			animation_player.play("player_won")
		
		if value_ticker >= 1:
			survived.emit()
		return
	
	value_ticker -= delta / timer_slowdown_strength
	value = value_ticker
	tint_progress = Color(1-value_ticker,1-value_ticker,1,1)
	
	if value_ticker <= min_value:
		win_sequence = true


func _on_visibility_changed() -> void:
	game_started = true
