extends Node

var screenshake_enabled : bool = true
signal trigger_light_screenshake()
signal trigger_medium_screenshake()
signal trigger_big_screenshake()

signal end_game()
var winner : String = ""

const PATTERN_PATH : String = "res://Prefabs/BlockPrefabs/PatternPrefabs/"
const TILE : Vector2 = Vector2(32.0,32.0)

var starting_timer : float = 60.0
var timer : float = starting_timer


func reset_game_parameters():
	winner = ""
	timer = starting_timer
