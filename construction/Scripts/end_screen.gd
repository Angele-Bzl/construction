extends Control

@onready var winner_label = $Structure/WinnerLabel
@onready var time_left_score_left = $Structure/TimeLeftScoreLeft

func _ready():
	GlobalManager.end_game.connect(show_end_label)
	

func show_end_label():
	visible = true
	
	match GlobalManager.winner:
		"Attacker":
			winner_label.text = "Winner : Attacker"
			time_left_score_left.text = "Time Left : " + str(GlobalManager.timer)
		"Defender":
			winner_label.text = "Winner : Defender"
			time_left_score_left.text = "Nexus Hp : " + str(Defender.nexus_hp) + " / " + str(Defender.nexus_max_hp)
