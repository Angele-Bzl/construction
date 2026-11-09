extends Node

signal pattern_snapped

var nexus_max_hp : float = 10.0
var nexus_hp : float = nexus_max_hp:
	set(value):
		nexus_hp = value
		if value <= 0.0:
			nexus_hp = 0.0
			GlobalManager.winner = "Attacker"
			GlobalManager.end_game.emit()

var cooldown_new_pattern : float = 1.0

func reset_game_parameters():
	nexus_hp = nexus_max_hp
