extends Control

@onready var animation_player = $AnimationPlayer

func change_scene(scene : String):
	animation_player.play("transi")
	
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file(scene)
	
	open_scene()

func open_scene():
	animation_player.play_backwards("transi")
