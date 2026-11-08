extends Block
class_name Nexus

@export var LEFT_DEFENDER_ZONE : int = 450
@export var RIGHT_DEFENDER_ZONE : int = 864
@export var TOP_DEFENDER_ZONE : int = 32
@export var HALF_DEFENDER_ZONE : int = 256

var rng = RandomNumberGenerator.new()
var x = rng.randi_range(LEFT_DEFENDER_ZONE, RIGHT_DEFENDER_ZONE)
var y = rng.randi_range(TOP_DEFENDER_ZONE, HALF_DEFENDER_ZONE)

func _ready():
	x = x - (x % 32)
	y = y - (y % 32)
	self.position = Vector2(x, y)

	is_collided.connect(take_damage)
	
	max_hp = Defender.nexus_max_hp
	current_hp = max_hp

func take_damage(bullet : Bullet):
	GlobalManager.trigger_big_screenshake.emit()
	current_hp -= bullet.damage
	Defender.nexus_hp = current_hp
