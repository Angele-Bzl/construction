extends Node2D

var rng = RandomNumberGenerator.new()

@onready var block_container = $BlockContainer
@onready var nexus = $Nexus
@onready var ground = $Ground

@export var block : PackedScene

var patterns : Array[PackedScene]

var next_pattern : PackedScene

func _ready():
	Defender.pattern_snapped.connect(generate_new_pattern)
	
	_get_pattern_files()
	
	await get_tree().process_frame
	
	generate_starting_elements(5)
	next_pattern = patterns.pick_random()
	generate_new_pattern()
	
	GlobalManager.start_game_timer()

#fonction pour récupérer les différents 
func _get_pattern_files():
	var scene_loads : Array
	
	var dir = DirAccess.open(GlobalManager.PATTERN_PATH)
	
	if dir:
		print("access to file")
		for file_name in dir.get_files():
			print(file_name)
			var file = load(GlobalManager.PATTERN_PATH + "/" + file_name)
			if file is PackedScene:
				print(file.get_script())
				print("is pattern")
				patterns.append(file)
	else:
		print("can't access pattern file")

func generate_starting_elements(starting_blocks : int):
	var range_x : Vector2 = Vector2(ground.global_position.x,ground.global_position.x + ground.size.x)
	var range_y : Vector2 = Vector2(ground.global_position.y,ground.global_position.y + ground.size.y/3)
	print("Range x : " + str(range_x))
	print("Range y : " + str(range_y))
	nexus.global_position = Vector2(rng.randi_range(range_x.x,range_x.y),rng.randi_range(range_y.x,range_y.y))
	print("Nexus position : " + str(nexus.global_position))
	nexus.global_position.x -= int(nexus.global_position.x) % int(GlobalManager.TILE.x*2)
	nexus.global_position.y -= int(nexus.global_position.y) % int(GlobalManager.TILE.y*2)
	print("Nexus position tile fixed : " + str(nexus.global_position))
	
	var valid_pos_for_blocks : Array[Vector2]
	var pos_around_nexus = [-2,-1,2,3]
	
	for i in pos_around_nexus:
		print(i)
		if nexus.global_position.x < ground.global_position.x + GlobalManager.TILE.x * 2 - int(ground.global_position.x) % int(GlobalManager.TILE.x*2) and i < 0:
			print("Collé à gauche")
		elif nexus.global_position.x > ground.global_position.x + ground.size.x - GlobalManager.TILE.x * 2 - int(ground.global_position.x) % int(GlobalManager.TILE.x*2) and i > 1:
			print("Collé à droite")
		else:
			for j in pos_around_nexus:
				if nexus.global_position.y <= ground.global_position.y - int(ground.global_position.y) % int(GlobalManager.TILE.y*2) and j < 0:
					print("Collé en haut")
				else:
					valid_pos_for_blocks.append(Vector2(i,j))
	
	print(valid_pos_for_blocks)
	
	valid_pos_for_blocks.shuffle()
	
	for i in starting_blocks:
		if !valid_pos_for_blocks.is_empty():
			var new_block : Block = block.instantiate()
			
			block_container.add_child(new_block)
			var new_pos_around_nexus = valid_pos_for_blocks.pop_front()
			var new_pos : Vector2
			new_pos.x = nexus.global_position.x + new_pos_around_nexus.x * GlobalManager.TILE.x + GlobalManager.TILE.x /2
			new_pos.y = nexus.global_position.y + new_pos_around_nexus.y * GlobalManager.TILE.y + GlobalManager.TILE.y /2
			
			print(new_pos)
			new_block.global_position = new_pos

func generate_new_pattern():
	if next_pattern:
		var new_pattern : Pattern = next_pattern.instantiate()
		new_pattern.global_position = ground.global_position
		block_container.add_child(new_pattern)
		new_pattern.select()
	if !patterns.is_empty():
		next_pattern = patterns.pick_random()
