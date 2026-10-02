extends TextureProgressBar

var thermo_counter : float = 1
@export var deplete_speed : int = 100

func _ready() -> void:
	texture_progress = preload("res://Shiver/RileySprites/ThermometerMercury.png")
	texture_over = preload("res://Shiver/RileySprites/PNG_Thermometer.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	thermo_counter -= delta / deplete_speed
	update_thermometer()

func update_thermometer():
	value = thermo_counter
	change_color()
	tint_progress = Color(1.0 - thermo_counter,1.0 - thermo_counter,1.0,1.0)
	

func change_color():
	if value <= 0.25: #lowest temp range
		pass
	elif value <= 0.33: 
		pass
	elif value <= 0.42:
		pass
	elif value <= 0.54:
		pass
	elif value <= 0.63:
		pass
	elif value <= 0.75:
		pass
	elif value <= 0.87: #second highest temp range
		pass
	return 
