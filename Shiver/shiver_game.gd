extends MicroGame

@onready var log_placer = $"Log Placer"
@onready var thermometer: TextureProgressBar = $Thermometer
@onready var campfire: CharacterBody3D = $Campfire

@onready var sfx_wind: AudioStreamPlayer = $SfxWind

func _ready() -> void:
	GameManager.get_node("Background").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	log_placer.start(self)
	
	thermometer.connect("survived", Callable(self, "player_won"))
	campfire.connect("fire_gone_out", Callable(self, "player_lost"))

# called when thermometer reaches zero and player still alive
func player_won() -> void:
	GameManager.win()
	
# called when the fire goes out and the player loses
func player_lost() -> void:
	GameManager.lose()

func _on_respawner_body_entered(body: Node3D) -> void:
	body.position.y = 20


func _on_sfx_wind_finished() -> void:
	sfx_wind.volume_db = randi_range(-20,0)
	sfx_wind.play(randi_range(0,8))
