extends AudioStreamPlayer3D


onready var spectrum: AudioEffectInstance = (
	AudioServer.get_bus_effect_instance(0, 0)
)

const bands: int = 3

const low_freq: int = 20
const mid_freq: int = 100
const high_freq: int = 5000
const max_freq: int = 20000

const min_db_low: int = -80
const max_db_low: int = -10

const min_db_mid: int = -60
const max_db_mid: int = -10

const min_db_high: int = -100
const max_db_high: int = -30

#var down_pitch: bool = false
#var pitch_threshold: float = pitch_scale

#var music_slowdown_offset: float = 0.2

#var min_music_speed: float = 0.5
#var max_music_speed: int = 5

signal freq_played(band, magnitude, delta)
#signal song_pitch(pitch_factor)


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !playing:
		return
	#print(pitch_scale)
#	if down_pitch:
#		pitch_scale = lerp(pitch_scale, min_music_speed, delta * 2)
#		if pitch_scale < pitch_threshold:
#			down_pitch = false
#	else:
#		pitch_scale = lerp(pitch_scale, max_music_speed, delta * 0.005)

#	pitch_scale = clamp(pitch_scale, min_music_speed, max_music_speed)

#	emit_signal("song_pitch", pitch_scale)
	
	for band in bands:
		if band == 0:
			var magnitude = spectrum.get_magnitude_for_frequency_range(low_freq, mid_freq)
			magnitude = linear2db(magnitude.length())
			#if magnitude < -60: continue
			
			magnitude = (magnitude - min_db_low) / (max_db_low - min_db_low)
			
			magnitude = clamp(magnitude, 0, 1)
			
			emit_signal("freq_played", "low", magnitude, delta)
			
		elif band == 1:
			var magnitude = spectrum.get_magnitude_for_frequency_range(mid_freq, high_freq)
			magnitude = linear2db(magnitude.length()) # Dynamic typing
			#if magnitude < -60: continue
			
			magnitude = (magnitude - min_db_mid) / (max_db_mid - min_db_mid)
			
			magnitude = clamp(magnitude, 0, 1)
			
			emit_signal("freq_played", "mid", magnitude, delta)
			
		elif band == 2:
			var magnitude = spectrum.get_magnitude_for_frequency_range(high_freq, max_freq)
			magnitude = linear2db(magnitude.length())
			#if magnitude < -60: continue
			
			magnitude = (magnitude - min_db_high) / (max_db_high - min_db_high)
			
			magnitude = clamp(magnitude, 0, 1)
			
			emit_signal("freq_played", "high", magnitude, delta)


#func _on_Player_clock_pickup() -> void:
#	pitch_threshold = clamp(
#		pitch_scale - music_slowdown_offset,
#		min_music_speed,
#		max_music_speed
#	)
#	down_pitch = true
