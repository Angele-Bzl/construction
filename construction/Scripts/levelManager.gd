extends Node2D

var rng = RandomNumberGenerator.new()

@onready var pattern_spawn = $PatternSpawn
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
	
	generate_starting_elements(3)
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
	var range_y : Vector2 = Vector2(ground.global_position.y/3,ground.global_position.y/3 + ground.size.y/3)
	print("Range x : " + str(range_x))
	print("Range y : " + str(range_y))
	nexus.global_position = Vector2(rng.randi_range(range_x.x,range_x.y),rng.randi_range(range_y.x,range_y.y))
	print("Nexus position : " + str(nexus.global_position))
	nexus.global_position.x -= int(nexus.global_position.x) % int(GlobalManager.TILE.x*2)
	nexus.global_position.y -= int(nexus.global_position.y) % int(GlobalManager.TILE.y*2)
	print("Nexus position tile fixed : " + str(nexus.global_position))
	
	for i in starting_blocks:
		pass

func generate_new_pattern():
	if next_pattern:
		var new_pattern : Pattern = next_pattern.instantiate()
		new_pattern.global_position = pattern_spawn.global_position
		block_container.add_child(new_pattern)
		new_pattern.select()
	if !patterns.is_empty():
		next_pattern = patterns.pick_random()
