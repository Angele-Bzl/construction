extends Node2D

@onready var pattern_spawn = $PatternSpawn
@onready var block_container = $BlockContainer

var patterns : Array[PackedScene]

func _ready():
	
	Defender.pattern_snapped.connect(generate_new_pattern)
	
	_get_pattern_files()
	
	await get_tree().process_frame
	
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
	
	print(patterns)

func generate_new_pattern():
	if !patterns.is_empty():
		var new_pattern : Pattern = patterns.pick_random().instantiate()
		new_pattern.global_position = pattern_spawn.global_position
		block_container.add_child(new_pattern)
		new_pattern.select()
