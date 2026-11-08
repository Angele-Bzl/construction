extends Node2D
class_name Crossbow

@export var bullet : PackedScene

@export var rotation_speed :float = 2.0
@onready var shoot_timer = $ShootCooldown
@export var shoot_cooldown : float = 2.0
@onready var anim_canon_trembling = $CrossbowSprite/CrossbowCannonSprite/AnimationPlayer_Trembling
@onready var anim_canon_charged= $CrossbowSprite/CrossbowCannonSprite/AnimationPlayer_Charged
@onready var aim_assist_image = $CrossbowSprite/CrossbowCannonSprite/AimAssistImage

@export var charge : float = 0.1

#---- Slider charge ----
@onready var texture_progress_bar: TextureProgressBar = $CrossbowSprite/CrossbowCannonSprite/Sprite2D/TextureProgressBar

@onready var bullet_spawn = $CrossbowSprite/CrossbowCannonSprite/BulletSpawn

func _process(delta):
	if Input.is_action_pressed("right_click"):
		if !AudioManager.bomb_fuse_sfx.playing:
			AudioManager.bomb_fuse_sfx.play()
		shoot()
	else:
		if AudioManager.bomb_fuse_sfx.playing:
			AudioManager.bomb_fuse_sfx.stop()
		aim_assist_image.visible = false

func _physics_process(delta):
	rotate_with_mouse_position(delta)

func rotate_with_mouse_position(delta : float = 0.2):
	var mouse_position = get_global_mouse_position()
	var angle_to_mouse = global_position.direction_to(mouse_position).angle()
	
	rotation = move_toward(rotation, angle_to_mouse, delta * rotation_speed)
	
func charging():
	charge += 0.1
	if charge > 4:
		charge = 4
	
	texture_progress_bar.value = charge
	if charge > 3: 
		aim_assist_image.visible = true
		aim_assist_image.size.y = 50.0 + 200.0 * (charge - 3.0)
		texture_progress_bar.self_modulate = Color("E93C3Cff")
		
		anim_canon_trembling.play("Trembling")
		anim_canon_charged.play("Charged")
		

func shoot():
	if Input.is_action_just_released("scroll_down"):
		charging()
	if shoot_timer.is_stopped() && Input.is_action_just_pressed("left_click") && Attacker.stock > 0 && charge > 3:
		AudioManager.cannon_sfx.play()
		#plus besoin a priori ?
		#shoot_timer.start(shoot_cooldown)
		var mouse_position = get_global_mouse_position()
		var angle_to_mouse = global_position.direction_to(mouse_position)
		
		var new_bullet : Bullet = bullet.instantiate()
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.global_position = bullet_spawn.global_position
		new_bullet.set_bullet_velocity(angle_to_mouse, charge)
		anim_canon_trembling.play("RESET")
		anim_canon_charged.play("RESET")
		charge = 0
		texture_progress_bar.value = 0
		texture_progress_bar.self_modulate = Color.WHITE
		Attacker.stock -= 1
