extends Node

var screenshake_enabled : bool = true
signal trigger_light_screenshake()
signal trigger_medium_screenshake()
signal trigger_big_screenshake()

signal end_game()
var winner : String = ""

const PATTERN_PATH : String = "res://Prefabs/BlockPrefabs/PatternPrefabs/"
const TILE : Vector2 = Vector2(32.0,32.0)

const PLAYGROUND_COORD : Vector2 = Vector2(288.0,16.0)
const PLAYGROUND_SIZE : Vector2 = Vector2(288.0,16.0)

var starting_timer : float = 60.0
var timer : Timer = Timer.new()

func _ready():
	add_child(timer)
	timer.timeout.connect(_timer_is_over)
	
	timer.one_shot = true
	timer.autostart = false

func _timer_is_over():
	winner = "Defender"
	end_game.emit()

func start_game_timer():
	timer.start(starting_timer)

func reset_game_parameters():
	winner = ""
	timer.stop()
