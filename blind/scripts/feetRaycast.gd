extends RayCast

func _process(delta):
	rotation.x = -get_parent().rotation.x
	rotation.z = -get_parent().rotation.z
