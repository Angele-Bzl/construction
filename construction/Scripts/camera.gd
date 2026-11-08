extends Camera2D

@export_category("Light Screenshake param")
var light_intensity : float = 5.0
var light_time :float = 0.1

@export_category("Medium Screenshake param")
var medium_intensity : float = 10.0
var medium_time :float = 0.1

@export_category("Big Screenshake param")
var big_intensity : float = 15.0
var big_time :float = 0.2

var shake_intensity : float = 0.0
var active_shake_time : float = 0.0

var shake_decay : float = 5.0

var shake_time : float = 0.0
var shake_time_speed : float = 20.0

var noise = FastNoiseLite.new()

func _ready():
	GlobalManager.trigger_light_screenshake.connect(light_screenshake)
	GlobalManager.trigger_medium_screenshake.connect(medium_screenshake)
	GlobalManager.trigger_big_screenshake.connect(big_screenshake)

func _physics_process(delta):
	if GlobalManager.screenshake_enabled:
		if active_shake_time > 0:
			shake_time += delta * shake_time_speed
			active_shake_time -= delta
			
			var param = Vector2(
				noise.get_noise_2d(shake_time,0) * shake_intensity,
				noise.get_noise_2d(0, shake_time) * shake_intensity
			)
			
			global_position.x = param.x
			global_position.y = param.y
			
			shake_intensity = max(shake_intensity - shake_decay * delta, 0)
		else:
			global_position.x = lerp(global_position.x, 0.0, 10.5 * delta)
			global_position.y = lerp(global_position.y, 0.0, 10.5 * delta)

func screen_shake(intensity : float, time : float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0

func light_screenshake():
	screen_shake(light_intensity,light_time)

func medium_screenshake():
	screen_shake(medium_intensity,medium_time)

func big_screenshake():
	screen_shake(big_intensity,big_time)
