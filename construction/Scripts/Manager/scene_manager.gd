extends Control

@onready var animation_player = $AnimationPlayer

var next_scene : String

func change_scene(scene : String):
	AudioManager.transi_sfx.play()
	animation_player.play("transi")
	next_scene = scene

func open_scene():
	get_tree().change_scene_to_file(next_scene)
