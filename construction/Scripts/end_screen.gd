extends Control

@onready var winner_label = $Structure/WinnerLabel
@onready var time_left_score_left = $Structure/TimeLeftScoreLeft

func _ready():
	GlobalManager.end_game.connect(show_end_label)
	visible = false

func show_end_label():
	visible = true
	get_tree().paused = true
	
	match GlobalManager.winner:
		"Attacker":
			winner_label.text = "Winner : Attacker"
			time_left_score_left.text = "Time Left : " + str(GlobalManager.timer.time_left).pad_decimals(1)
		"Defender":
			winner_label.text = "Winner : Defender"
			time_left_score_left.text = "Nexus Hp : " + str(Defender.nexus_hp) + " / " + str(Defender.nexus_max_hp)


func _on_retry_button_pressed():
	get_tree().paused = false
	AudioManager.fade_out(AudioManager.game_music)
	GlobalManager.reset_game_parameters()
	Attacker.reset_game_parameters()
	Defender.reset_game_parameters()
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_main_menu_button_pressed():
	get_tree().paused = false
	AudioManager.fade_out(AudioManager.game_music)
	GlobalManager.reset_game_parameters()
	Attacker.reset_game_parameters()
	Defender.reset_game_parameters()
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
