extends Spatial

signal mapDataComplete

const AMPLITUDE = 7
const HEIGHT = 1

var noiseEdge = OpenSimplexNoise.new()
var noiseTerrain = OpenSimplexNoise.new()

var noiseSeed = 1475251885

#----# NOISE PRESETS #----#

#GENERIC
#noise.seed = 452
#noise.octaves = 3
#noise.period = 36
#noise.persistence = 0.7
#noise.lacunarity = 2

#TEST THING


func _ready():
	noiseTerrain.seed = noiseSeed
	noiseTerrain.octaves = 3
	noiseTerrain.period = 67
	noiseTerrain.persistence = 0.2
	noiseTerrain.lacunarity = 6
	
	noiseEdge.seed = noiseSeed
	noiseEdge.octaves = 3
	noiseEdge.period = 100
	noiseEdge.persistence = 1
	noiseEdge.lacunarity = 2.4
	
	$water/waterCollisionMap.shape.map_width = $ground/groundCollisionMap.shape.map_width
	$water/waterCollisionMap.shape.map_depth = $ground/groundCollisionMap.shape.map_depth

	
	for x in $ground/groundCollisionMap.shape.map_width:
		for y in $ground/groundCollisionMap.shape.map_depth:
			$water/waterCollisionMap.shape.map_data[x*$ground/groundCollisionMap.shape.map_width+y] = -10
			if Vector2($ground/groundCollisionMap.shape.map_width/2, $ground/groundCollisionMap.shape.map_depth/2).distance_to(Vector2(x,y)) + abs(noiseEdge.get_noise_2d(x,y))*75>95:
				$ground/groundCollisionMap.shape.map_data[x*$ground/groundCollisionMap.shape.map_width+y] = HEIGHT + 10
			elif abs(((x-$ground/groundCollisionMap.shape.map_width/2)*noiseEdge.get_noise_2d(1, 1)+(y-$ground/groundCollisionMap.shape.map_depth/2)*noiseEdge.get_noise_2d($ground/groundCollisionMap.shape.map_depth, 1))/sqrt(pow(noiseEdge.get_noise_2d(1, 1), 2) + pow(noiseEdge.get_noise_2d($ground/groundCollisionMap.shape.map_depth, 1), 2))) < 3.5:
				$ground/groundCollisionMap.shape.map_data[x*$ground/groundCollisionMap.shape.map_width+y] = noiseTerrain.get_noise_2d(x,y)*AMPLITUDE
				$water/waterCollisionMap.shape.map_data[x*$ground/groundCollisionMap.shape.map_width+y] = HEIGHT-0.5 + noiseTerrain.get_noise_2d(x,y)*AMPLITUDE
			else:
				$ground/groundCollisionMap.shape.map_data[x*$ground/groundCollisionMap.shape.map_width+y] = HEIGHT + noiseTerrain.get_noise_2d(x,y)*AMPLITUDE# + Vector2(shape.map_width/2,shape.map_depth/2).distance_to(Vector2(x,y))/15
	emit_signal("mapDataComplete")
