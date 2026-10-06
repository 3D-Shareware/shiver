class_name DanceLevelStats
extends Resource

@export_group("Keys")
@export var key_pool: Array[InputEvent]
@export var key_visuals: PackedScene = preload("uid://cgm8nshwkqev3")
@export var key_speed: float = 250
@export var max_tries: int = 3
@export var retry_delay: float = 1.5

@export_group("Music")
@export var music: AudioStream
@export var qte_duration: float = 10.0
@export var spawn_interval: float = 1.0
