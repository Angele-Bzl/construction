extends Node

signal pattern_snapped

var nexus_max_hp : float = 20.0
var nexus_hp : float = nexus_max_hp


func reset_game_parameters():
	nexus_hp = nexus_max_hp
