extends Node2D
class_name Pattern

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
	if is_selected:
		if Input.is_action_just_pressed("left"):
			global_position.x -= GlobalManager.TILE.x
		if Input.is_action_just_pressed("right"):
			global_position.x += GlobalManager.TILE.x
		if Input.is_action_just_pressed("up"):
			global_position.y -= GlobalManager.TILE.y
		if Input.is_action_just_pressed("down"):
			global_position.y += GlobalManager.TILE.y
		
		if can_snap():
			for block in get_blocks():
				block.switch_color_filter(true,true)
		else:
			for block in get_blocks():
				block.switch_color_filter(true,false)

func get_blocks() -> Array[Block]:
	var blocks : Array[Block]
	for i in get_children():
		if i is Block:
			blocks.append(i)
	return blocks

func activate_blocks():
	for block in get_blocks():
		block.switch_collision_activation(true)
		block.switch_color_filter(true)

func desactivate_blocks():
	for block in get_blocks():
		block.switch_collision_activation(false)
		block.switch_color_filter(false)

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
		deselect()
