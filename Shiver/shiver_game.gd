extends MicroGame

@onready var log_placer = $"Log Placer"
@onready var tree_placer = $"Tree Placer"
@onready var thermometer: TextureProgressBar = $Thermometer
@onready var campfire: CharacterBody3D = $Campfire

@onready var sfx_wind: AudioStreamPlayer = $SfxWind
@onready var instructions: Control = $Instructions

var started : bool = false


func _ready() -> void:
	GameManager.get_node("Background").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	log_placer.start(self)
	tree_placer.start(self)
	
	thermometer.connect("survived", Callable(GameManager, "win"))
	campfire.connect("fire_gone_out", Callable(self, "initate_loss"))

func initate_loss() -> void:
	if thermometer.win_sequence:
		return
	
	thermometer.game_started = false
	started = false
	
	GameManager.lose()

func _on_respawner_body_entered(body: Node3D) -> void:
	body.position.y = 20


func _on_sfx_wind_finished() -> void:
	sfx_wind.play(randi_range(0,8))

func _on_instruction_timer_timeout() -> void:
	instructions.visible = false
	thermometer.visible = true
	campfire.visible = true
	started = true
