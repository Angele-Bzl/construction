extends Node

var rng = RandomNumberGenerator.new()

@onready var bump_sfx = $SFX/BumpSFX
@onready var plop_sfx = $SFX/PlopSFX
@onready var click_sfx = $SFX/ClickSFX

func fade_out(stream_player : AudioStreamPlayer, time : float = 1.5, volume : float = -20.0):
	if stream_player.playing:
		var tween = create_tween()
		tween.tween_property(stream_player, "volume_db", volume, time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		await tween.finished
		stream_player.stop()

func fade_in(stream_player : AudioStreamPlayer, time : float = 1.0, volume : float = 0.0, starting_volume : float = -20):
	if !stream_player.playing:
		stream_player.volume_db = starting_volume
		stream_player.play()
		var tween = create_tween()
		tween.tween_property(stream_player, "volume_db", volume, time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

func duck_in(stream_player : AudioStreamPlayer):
	var tween = create_tween()
	tween.tween_property(stream_player, "volume_db", -10, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

func duck_out(stream_player : AudioStreamPlayer):
	var tween = create_tween()
	tween.tween_property(stream_player, "volume_db", 0, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

func set_bus_db(bus_name : String, value : float):
	var bus = AudioServer.get_bus_index(bus_name)
	if bus_name == "Master":
		AudioServer.set_bus_volume_db(bus,linear_to_db(value) + 6)
	else:
		AudioServer.set_bus_volume_db(bus,linear_to_db(value))

func play_sound_with_rdm_pitch(stream_player : AudioStreamPlayer, range_pitch : Vector2 = Vector2(0.5,1.5)):
	stream_player.pitch_scale = rng.randf_range(range_pitch.x,range_pitch.y)
	stream_player.play()

func fade_out_array(array_stream_player : Array[AudioStreamPlayer]):
	for stream_player in array_stream_player:
		fade_out(stream_player)
