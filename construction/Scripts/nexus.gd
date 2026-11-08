extends Block
class_name Nexus

func _ready():
	is_collided.connect(take_damage)
	
	max_hp = Defender.nexus_max_hp
	current_hp = max_hp

func take_damage(bullet : Bullet):
	GlobalManager.trigger_big_screenshake.emit()
	AudioManager.play_sound_with_rdm_pitch(AudioManager.bump_sfx)
	current_hp -= bullet.damage
	Defender.nexus_hp = current_hp
	impact_animation.play("Impact_nexus")
