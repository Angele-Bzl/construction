extends Label

func _process(delta):
	global_position.y -= 2.0
	modulate.a -= 0.02

func _on_timer_timeout():
	queue_free()
