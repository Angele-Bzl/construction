extends Block
class_name Nexus

func _ready():
	is_collided.connect(take_damage)
	
	max_hp = Defender.nexus_max_hp
	current_hp = max_hp

func take_damage(bullet : Bullet):
	GlobalManager.trigger_big_screenshake.emit()
	current_hp -= bullet.damage
	Defender.nexus_hp = current_hp
