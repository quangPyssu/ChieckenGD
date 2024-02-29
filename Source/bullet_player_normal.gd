extends bullet

func _ready():
	inClampedScreen=false

	speed=1000.0
	direction=Vector2(0,-1)
	accelaration=100
	rotation_degrees=-90
