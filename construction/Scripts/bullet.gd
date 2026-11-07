extends CharacterBody2D
class_name Bullet

@export var base_speed : float = 300.0

func _physics_process(delta):
	var collision_info = move_and_collide((velocity * delta))
	if collision_info:
		print(collision_info)
		velocity = velocity.bounce(collision_info.get_normal())

func set_bullet_velocity(angle : Vector2):
	velocity = angle * base_speed
