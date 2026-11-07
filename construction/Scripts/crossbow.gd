extends Node2D
class_name Crossbow

@export var bullet : PackedScene

@export var rotation_speed :float = 2.0
@onready var shoot_timer = $ShootCooldown
@export var shoot_cooldown : float = 2.0

var is_loaded : bool = false

@onready var bullet_spawn = $CrossbowSprite/CrossbowCannonSprite/BulletSpawn

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_released("scroll_down"):
		reload()

func _physics_process(delta):
	rotate_with_mouse_position(delta)

func rotate_with_mouse_position(delta : float = 0.2):
	var mouse_position = get_global_mouse_position()
	var angle_to_mouse = global_position.direction_to(mouse_position).angle()
	
	rotation = move_toward(rotation, angle_to_mouse, delta * rotation_speed)
	
func reload():
	is_loaded = true
	print("reloaded.")
		
	

func shoot():
	print("shooting...")
	if shoot_timer.is_stopped() && is_loaded == true && Input.is_action_pressed("bow"):
		shoot_timer.start(shoot_cooldown)
		var mouse_position = get_global_mouse_position()
		var angle_to_mouse = global_position.direction_to(mouse_position)
		
		var new_bullet : Bullet = bullet.instantiate()
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = bullet_spawn.global_position
		new_bullet.set_bullet_velocity(angle_to_mouse)
		is_loaded = false
		print("shot.")
