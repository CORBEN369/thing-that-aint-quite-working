extends KinematicBody

var GROUNDNODE = null

const SPEED = 1
const GRAVITY = -0.5
const FRICTION = 0.9
const JUMPHEIGHT = 20
var mouseSpeed = Vector2(0, 0)
var mouseSensitivity =0.0001
var velocity = Vector3(0, 0, 0)

func _ready():
	for child in get_parent().get_children():
		if child.name == 'terrain':
			for child2 in get_parent().get_children():
				if child.name == 'ground':
					GROUNDNODE = child2
	
func _input(event):
	if event is InputEventMouseMotion:
		mouseSpeed = event.relative

func _process(delta):
	#player "camera" rotation
	rotation.x = min(max(rotation.x-mouseSpeed.y*mouseSensitivity, -0.444*PI), 0.444*PI)
	rotation.y = fmod(rotation.y-mouseSpeed.x*mouseSensitivity, 2*PI)
	
	#reset mouse speed. make it nice and cool and nice
	mouseSpeed = Vector2(0, 0)


# CURRENT STATE
# trying to redo ground detection. 
# wanted to make footstep noises ect.
# the ground collision looks wierd idk, the character seems way to high off the ground
# see if thets the case with a camera?
# feet area collision doesnt work
# time is running away, not yet left though, still inside


func _physics_process(delta):
	print(GROUNDNODE, 'groudnode')
	print($feetArea.get_overlapping_bodies(), "overlapping bods")
	#grav+fric
	velocity.y += GRAVITY*int(!$feetArea.get_overlapping_bodies().has(GROUNDNODE)) + JUMPHEIGHT*int($feetArea.get_overlapping_bodies().has(GROUNDNODE))*int(Input.is_action_just_pressed("player_input_jump"))
	velocity.x = velocity.x*FRICTION
	velocity.z = velocity.z*FRICTION
	#input
	velocity += Vector3(-SPEED*sin(rotation.y), 0, -SPEED*cos(rotation.y))*int(Input.is_action_pressed("player_input_foward"))
	velocity += Vector3(-SPEED*cos(rotation.y), 0, SPEED*sin(rotation.y))*int(Input.is_action_pressed("player_input_left"))
	velocity += Vector3(SPEED*cos(rotation.y), 0, -SPEED*sin(rotation.y))*int(Input.is_action_pressed("player_input_right"))
	velocity += Vector3(SPEED*sin(rotation.y), 0, SPEED*cos(rotation.y))*int(Input.is_action_pressed("player_input_back"))
	#movement
	velocity = move_and_slide(velocity)



