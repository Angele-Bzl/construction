extends Node2D
class_name Pattern

@export var pattern_img : CompressedTexture2D
@onready var movement_cooldown = $MovementCooldown

@export var largeur : int = 96
@export var hauteur : int = 64

var is_selected = false:
	set(value):
		is_selected = value
		if value:
			z_index = 10
		else:
			z_index = 0

func _ready():
	select()

func _process(delta):
	if is_selected and movement_cooldown.is_stopped():
		if Input.is_action_pressed("left"):
			if !is_on_border_left():
				global_position.x -= GlobalManager.TILE.x
				movement_cooldown.start(0.08)
		if Input.is_action_pressed("right"):
			if !is_on_border_right():
				global_position.x += GlobalManager.TILE.x
				movement_cooldown.start(0.08)
		if Input.is_action_pressed("up"):
			if !is_on_border_top():
				global_position.y -= GlobalManager.TILE.y
				movement_cooldown.start(0.08)
		if Input.is_action_pressed("down"):
			if !is_on_border_bottom():
				global_position.y += GlobalManager.TILE.y
				movement_cooldown.start(0.08)
		
		if can_snap():
			for block in get_blocks():
				block.switch_color_filter(true,true)
		else:
			for block in get_blocks():
				block.switch_color_filter(true,false)
		
		if Input.is_action_just_pressed("snap"):
			snap_to_ground()

func is_on_border_left() -> bool:
	var border : bool = false
	
	if global_position.x <= GlobalManager.PLAYGROUND_COORD.x:
		border = true
	
	return border

func is_on_border_right() -> bool:
	var border : bool = false
	
	if global_position.x + largeur >= GlobalManager.PLAYGROUND_COORD.x + GlobalManager.PLAYGROUND_SIZE.x:
		border = true
	
	return border

func is_on_border_top() -> bool:
	var border : bool = false
	
	if global_position.y <= GlobalManager.PLAYGROUND_COORD.y:
		border = true
	
	return border

func is_on_border_bottom() -> bool:
	var border : bool = false
	
	if global_position.y + hauteur >= GlobalManager.PLAYGROUND_COORD.y + GlobalManager.PLAYGROUND_SIZE.y:
		border = true
	
	return border

func get_blocks() -> Array[Block]:
	var blocks : Array[Block]
	for i in get_children():
		if i is Block:
			blocks.append(i)
	return blocks

func activate_blocks():
	for block in get_blocks():
		block.switch_collision_activation(true)
		block.switch_color_filter(false)

func desactivate_blocks():
	for block in get_blocks():
		block.switch_collision_activation(false)
		block.switch_color_filter(true)

func select():
	is_selected = true
	desactivate_blocks()

func deselect():
	is_selected = false
	activate_blocks()

func can_snap() -> bool:
	var tamp : bool = true
	for block in get_blocks():
		if !block.can_snap():
			tamp = false
	return tamp

func snap_to_ground():
	if can_snap():
		AudioManager.landing_sfx.play()
		deselect()
		Defender.pattern_snapped.emit()
		
		for block in get_blocks():
			block.land_anim()
		
	else:
		print("Can't snap pattern here !")
		for block in get_blocks():
			print(block.name)
			for entity in block.block_detection.get_overlapping_bodies():
				print("Overlap with " + entity.name)
		
