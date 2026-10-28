extends bullet

func _ready():
	inClampedScreen=false

	speed=1000.0
	
	accelaration=100
	
	if (direction==Vector2.ZERO):
		direction=Vector2(0,-1)
		rotation_degrees=-90
