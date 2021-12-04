extends AudioStreamPlayer3D

export var pitchVariance = 0.0
export var dbVariance = 0.0
export var speedVariance = 0.0

onready var PLAYER = get_parent().get_child(0)

func _process(delta):
	attenuation_filter_cutoff_hz = max(round(20000/max(((PLAYER.translation-translation).normalized().angle_to(Vector3(sin(PLAYER.rotation.y), sin(PLAYER.rotation.x), cos(PLAYER.rotation.y)))-0.8)*0.8, 1)), 10000)


func _on_sound_finished():
	queue_free()
