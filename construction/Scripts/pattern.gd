extends Node2D
class_name Pattern

func get_blocks() -> Array[Block]:
	var blocks : Array[Block]
	for i in get_children():
		if i is Block:
			blocks.append(i)
	return blocks
