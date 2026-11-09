extends CharacterBody2D
class_name Bullet

@export var base_speed : float = 700.0
@export var damage : float = 1.0
@export var velocity_loss : float = 0.95
@export var life_point : int = 20

@export var ammo_info : PackedScene

func _physics_process(delta):
	var collision_info = move_and_collide((velocity * delta))
	if collision_info:
		#on récupère le node qui est entré en collision
		var collider = collision_info.get_collider()
		
		if collider:
			#si c'est un block, on lui dit de gérer ses collisions de son côté, avec la balle en paramètre
			if collider is Block:
				collider.is_collided.emit(self)
			#si c'est une bullet, elle donne sa velocité et peut donc la reaccélerer
			if collider is Bullet:
				if collider.velocity < velocity:
					collider.velocity = velocity
		velocity = velocity.bounce(collision_info.get_normal()) * velocity_loss
		life_point -= 1
		#si la bullet a tapé X fois, elle retourne dans le stock
		if life_point == 0:
			go_back_to_stock()

func go_back_to_stock():
	Attacker.stock += 1
	
	var new_ammo_info = ammo_info.instantiate()
	get_tree().current_scene.add_child(new_ammo_info)
	new_ammo_info.global_position = global_position
	
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(0.001,0.001),1.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	
	await get_tree().create_timer(1.0)
	queue_free()

func set_bullet_velocity(angle : Vector2, charge : float):
	velocity = angle * base_speed * charge
