extends Control

@onready var nexus_hp_label = $AttackerInfoPanel/VBoxContainer/Score
@onready var nb_pallets_label = $AttackerInfoPanel/VBoxContainer/NbPallets

@onready var timer_label = $DefenderInfoPanel/VBoxContainer/Timer
@onready var nextblock_image = $DefenderInfoPanel/VBoxContainer/NextblockImage

var tamp_nexus_hp : float
var tamp_pallets : int

func _ready():
	GlobalManager.end_game.connect(hide_hud)

func _process(delta):
	if tamp_nexus_hp != Defender.nexus_hp:
		nexus_hp_label.text = "Nexus HP : " + str(Defender.nexus_hp) + " / " + str(Defender.nexus_max_hp)
	if tamp_pallets != Attacker.stock:
		nb_pallets_label.text = "Nb pallets left : " + str(Attacker.stock)
	timer_label.text = "Time left : " + str(GlobalManager.timer.time_left).pad_decimals(1)
	
	update_tamps()

func update_tamps():
	tamp_nexus_hp = Defender.nexus_hp
	tamp_pallets = Attacker.stock

func hide_hud():
	visible = false
