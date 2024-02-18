extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	play("ChickenBody_Flap")
	$AnimationPlayer.play("ChickenBody_Flapping")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("TestButton+"):
		play("ChickenBody_Hurt")
	else : 
		play("ChickenBody_Flap")
	
