extends GridMap

onready var mesh = get_parent().shape

func _on_terrain_mapDataComplete():
	for x in mesh.map_width:
		for y in mesh.map_depth:
			set_cell_item(
				y-(mesh.map_width/2),
				(mesh.map_data[x*mesh.map_width+y]/cell_size.y)-40,
				x-(mesh.map_depth/2),
				0
				)
