extends StaticBody2D
class_name Block

@onready var block_sprite = $BlockSprite

@export var max_hp : float = 5.0
var current_hp : float = max_hp:
	set(value):
		current_hp = value
		var ratio = value/max_hp
		block_sprite.self_modulate = Color(1,ratio,ratio)
		if current_hp <= 0.0:
			kill_self()


func kill_self():
	queue_free()
