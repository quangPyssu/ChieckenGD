extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	play("ChickenBody_Flap")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("TestButton+"):
		play("ChickenBody_Hurt")
	else : 
		play("ChickenBody_Flap")


	# offset the chicken face base on the spritesheet

	$ChickenFaces.offset = Vector2($ChickenFaces.frame_coords) * Vector2(0.1, 0.1)

	if Input.is_action_pressed("TestButton+"):
		$ChickenFaces.set_frame(($ChickenFaces.get_frame()+1)%75)
	
