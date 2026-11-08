extends Button
class_name BouncyButton

var b_tween : Tween

func _ready():
	pivot_offset = size/2

func _on_mouse_entered():
	pivot_offset = size/2
	if b_tween:
		b_tween.kill()
	b_tween = create_tween()
	b_tween.tween_property(self,"scale",Vector2(1.3,1.3),0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	
	await get_tree().create_timer(0.2).timeout
	
	AudioManager.play_sound_with_rdm_pitch(AudioManager.plop_sfx)


func _on_mouse_exited():
	if b_tween:
		b_tween.kill()
	
	b_tween = create_tween()
	b_tween.tween_property(self,"scale",Vector2(1,1),0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_pressed():
	AudioManager.click_sfx.play()
	if b_tween:
		b_tween.kill()
	
	b_tween = create_tween()
	b_tween.tween_property(self,"scale",Vector2(0.8,0.8),0.02).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	b_tween.tween_property(self,"scale",Vector2(1.3,1.3),0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
