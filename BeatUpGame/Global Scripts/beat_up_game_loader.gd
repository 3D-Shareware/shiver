extends MicroGame

@onready var playIntro = $Introscreen

func startRound() -> void:
	get_tree().change_scene_to_file("res://BeatUpGame/Room/Scenes/room.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playIntro.StartIntro()
	playIntro.canStart.connect(startRound)
