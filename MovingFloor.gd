extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var music_instance = get_node("../ARVROrigin/RightController/Music")
# Called when the node enters the scene tree for the first time.
func _ready():
	music_instance.connect("freq_played", self, "_on_GameMusic_freq_played")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_GameMusic_freq_played(band, magnitude, delta):
	match band:
		"low":
			var old_val = mesh.material.get_shader_param("multiple_low")
			var val = lerp(old_val, 1 * magnitude, 0.06)
			mesh.material.set_shader_param("multiple_low", val)
		"mid":
			var old_val = mesh.material.get_shader_param("multiple_mid")
			var val = lerp(old_val, 2 * magnitude, 0.1)
			mesh.material.set_shader_param("color_adder", val * 0.5)
			mesh.material.set_shader_param("multiple_mid", val)
		"high":
			var old_val = mesh.material.get_shader_param("multiple_high")
			var val = lerp(old_val, 0.2 * magnitude, 0.7)
			mesh.material.set_shader_param("multiple_high", val)
