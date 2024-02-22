extends AnimatedSprite2D

var lookVel:Vector2= Vector2.ZERO

var currentLookDir:Vector2i = Vector2i(7,3)
var targetLookDir:Vector2i = Vector2i(7,3)

const visionBox:Vector2i = Vector2i(700/15,700/5)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("TestButton+"):
		play("ChickenBody_Hurt")
	else : 
		play("default")

	# offset the chicken face base on the spritesheet

	$ChickenFaces.offset = Vector2($ChickenFaces.frame_coords) * Vector2(0.5, 0.5)+ Vector2(-4, -12)
	
	#head move up and down with the body going down from 0 to 49 and back up from 50 to 99
	var bodyFrame:float = get_frame()-50

	$ChickenFaces.offset.y -= 5 - 0.4* abs(bodyFrame)
	$ChickenShirt.offset.y =  0.4* abs(bodyFrame-1) - 19	
	
	_set_look_dir()
		
func _look_at_player(PlayerPos:Vector2):
	#look at the playerasas
	var lookAt:Vector2i = Vector2i(PlayerPos - global_position)/visionBox
	#the visionShape is a rectangle that around the chicken that is used to detect the player
	#15x5 is the size of the sprite sheet
	#get sprite sheet position based on the lookAt 
	lookAt=lookAt+Vector2i(7,3)
	targetLookDir = Vector2i(lookAt)


func _reset_look():
	lookVel=Vector2.ZERO
	targetLookDir = Vector2i(7,3)

func _set_look_dir():
	
	#move the look direction to the target
	currentLookDir = $ChickenFaces.frame_coords

	#all is int	
	lookVel = (targetLookDir - currentLookDir)
	#set to 1 or -1
	if lookVel.x>0:
		lookVel.x=1
	elif lookVel.x<0:
		lookVel.x=-1

	if lookVel.y>0:
		lookVel.y=1
	elif lookVel.y<0:
		lookVel.y=-1

	#print(lookVel)

	$ChickenFaces.frame_coords.x = clamp($ChickenFaces.frame_coords.x+lookVel.x,0,14)
	$ChickenFaces.frame_coords.y = clamp($ChickenFaces.frame_coords.y+lookVel.y,0,4)
