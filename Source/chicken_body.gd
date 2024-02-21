extends AnimatedSprite2D

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

	$ChickenFaces.offset = Vector2($ChickenFaces.frame_coords) * Vector2(0.5, 0.5)+ Vector2(-5, 0)
	
	#head move up and down with the body going down from 0 to 49 and back up from 50 to 99
	var bodyFrame:float = get_frame()-50

	$ChickenFaces.offset.y -= 5 - 0.1 * abs(bodyFrame)
	$ChickenShirt.offset.y =  0.3* abs(bodyFrame-1) - 17	

	if Input.is_action_pressed("TestButton+"):
		$ChickenFaces.set_frame(($ChickenFaces.get_frame()+1)%75)

	if Input.is_action_pressed("ui_right"):
		$ChickenFaces.frame_coords.x += 1
	if Input.is_action_pressed("ui_left"):
		$ChickenFaces.frame_coords.x -= 1
	if Input.is_action_pressed("ui_down"):
		$ChickenFaces.frame_coords.y += 1
	if Input.is_action_pressed("ui_up"):
		$ChickenFaces.frame_coords.y -= 1

func _look_at_player(PlayerPos:Vector2):
	#look at the player
	var lookDir = PlayerPos - global_position
	$ChickenFaces.flip_h = lookDir.x < 0
	$ChickenShirt.flip_h = lookDir.x < 0

func _reset_look():
	$ChickenFaces.frame_coords = Vector2(7,2)
