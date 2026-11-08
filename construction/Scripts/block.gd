extends RigidBody2D
class_name Block

@onready var block_sprite = $BlockSprite
@onready var block_top = $BlockSprite/BlockTop
@onready var filter = $ColorFilter
@onready var block_detection = $BlockDetection

@export var max_hp : float = 5.0

var current_hp : float = max_hp:
	set(value):
		current_hp = value
		var ratio = value/max_hp
		block_sprite.self_modulate = Color(1,ratio,ratio)
		block_top.self_modulate = Color(1,ratio,ratio)
		if current_hp <= 0.0:
			die()
signal is_collided(bullet : Bullet)

func _ready():
	is_collided.connect(take_damage)

func _integrate_forces(state):
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		
		if collider:
			print(str(name) + " : je suis touché par " + str(collider.name))
			if collider is Bullet:
				take_damage(collider)

func take_damage(bullet : Bullet):
	current_hp -= bullet.damage
	GlobalManager.trigger_light_screenshake.emit()

func can_snap() -> bool:
	if collision_layer == 0 and block_detection.get_overlapping_bodies().size() == 0:
		return true
	return false

func switch_collision_activation(b : bool):
	if b:
		collision_layer = 1
		collision_mask = 1
		block_sprite.modulate.a = 1.0
	else:
		collision_layer = 0
		collision_mask = 0
		block_sprite.modulate.a = 0.7

func switch_color_filter(show : bool, color : bool = true):
	filter.visible = show
	if color:
		filter.modulate = Color(0,1,0)
	else:
		filter.modulate = Color(1,0,0)

func die():
	GlobalManager.trigger_medium_screenshake.emit()
	queue_free()
