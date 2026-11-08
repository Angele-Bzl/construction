extends Area2D
class_name Barrier

func _on_body_entered(body):
	if body is Bullet:
		body.go_back_to_stock()
