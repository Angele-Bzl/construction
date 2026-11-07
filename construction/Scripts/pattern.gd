extends Node2D
class_name Pattern

var is_selected = false:
	set(value):
		is_selected = value
		if value:
			desactivate_blocks()
			z_index = 10
		else:
			activate_blocks()
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

func get_blocks() -> Array[Block]:
	var blocks : Array[Block]
	for i in get_children():
		if i is Block:
			blocks.append(i)
	return blocks

func activate_blocks():
	for block in get_blocks():
		block.switch_collision_activation(true)

func desactivate_blocks():
	for block in get_blocks():
		block.switch_collision_activation(false)

func select():
	is_selected = true

func can_snap() -> bool:
	return true

func snap_to_ground():
	if can_snap():
		is_selected = false
