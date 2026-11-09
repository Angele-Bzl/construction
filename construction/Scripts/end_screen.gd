extends Control

@onready var winner_label = $VBoxContainer/WinnerLabel
@onready var time_left_score_left = $VBoxContainer/TimeLeftScoreLeft

func _ready():
	GlobalManager.end_game.connect(show_end_label)
	visible = false

func show_end_label():
	Input.set_custom_mouse_cursor(null)
	AudioManager.fade_out(AudioManager.wind_ambient)
	visible = true
	global_position.y = -size.y
	
	var tween = create_tween()
	tween.tween_property(self,"global_position",Vector2(0,0),1.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	match GlobalManager.winner:
		"Attacker":
			winner_label.text = "Winner : Attacker"
			time_left_score_left.text = "Time Left : " + str(GlobalManager.timer.time_left).pad_decimals(1)
		"Defender":
			winner_label.text = "Winner : Defender"
			time_left_score_left.text = "Nexus Hp : " + str(Defender.nexus_hp) + " / " + str(Defender.nexus_max_hp)
	
	await tween.finished
	
	GlobalManager.hide_hud.emit()
	
	get_tree().paused = true
	AudioManager.bomb_fuse_sfx.stop()
	


func _on_retry_button_pressed():
	get_tree().paused = false
	GlobalManager.reset_game_parameters()
	Attacker.reset_game_parameters()
	Defender.reset_game_parameters()
	SceneManager.change_scene("res://Scenes/main_scene.tscn")


func _on_main_menu_button_pressed():
	get_tree().paused = false
	AudioManager.fade_out(AudioManager.game_music)
	GlobalManager.reset_game_parameters()
	Attacker.reset_game_parameters()
	Defender.reset_game_parameters()
	SceneManager.change_scene("res://Scenes/title_screen.tscn")
