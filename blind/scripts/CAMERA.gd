extends Camera


func _ready():
	pass # Replace with function body.

func _process(delta):
	translation = get_parent().get_child(0).translation
	translation.y = 20
	rotation.y = get_parent().get_child(0).rotation.y


