extends bullet

func _ready():
	BounceCount=0
	inClampedScreen=false

	BaseSpeed=1000.0
	direction=Vector2(0,-1)
	accelaration=100
	rotation_degrees=-90
