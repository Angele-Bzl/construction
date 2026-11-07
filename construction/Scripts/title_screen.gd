extends Control

@onready var ts_main: Control = $TSMain
@onready var start_game_button: Button = $TSMain/MarginContainer/VBoxContainer2/VBoxContainer/StartGameButton
@onready var how_to_play_button: Button = $TSMain/MarginContainer/VBoxContainer2/VBoxContainer/HowToPlayButton
@onready var option_button: Button = $TSMain/MarginContainer/VBoxContainer2/VBoxContainer/OptionButton
@onready var credits_button: Button = $TSMain/MarginContainer/VBoxContainer2/VBoxContainer/CreditsButton
@onready var quit_button: Button = $TSMain/MarginContainer/VBoxContainer2/VBoxContainer/QuitButton


@onready var ts_how_to_play: Control = $TSHowToPlay
@onready var htp_quit_button: Button = $TSHowToPlay/MarginContainer/HTPQuitButton


func _ready() -> void:
	if start_game_button: 
		start_game_button.pressed.connect(_on_start_game_button)
	if quit_button: 
		quit_button.pressed.connect(_on_quit_button_pressed)
	if option_button: 
		option_button.pressed.connect(_on_option_button_pressed)
	if how_to_play_button: 
		how_to_play_button.pressed.connect(_on_how_to_play_button_pressed)
	if credits_button: 
		credits_button.pressed.connect(_on_credit_button_pressed)
	if htp_quit_button:
		htp_quit_button.pressed.connect(_on_close_button_pressed)
	
	ts_main.show()
	ts_how_to_play.hide()

func _on_start_game_button() -> void: 
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_option_button_pressed() -> void: 
	pass

func _on_how_to_play_button_pressed() -> void:
	ts_main.hide()
	ts_how_to_play.show()

func _on_credit_button_pressed() -> void:
	pass

func _on_close_button_pressed() -> void:
	ts_main.show()
	ts_how_to_play.hide()
