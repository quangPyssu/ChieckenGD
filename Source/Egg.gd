extends bullet

func _ready():
	inClampedScreen=false
	
	HP=1
	speed=300.0
	direction=Vector2(0,1)
	accelaration=0
	if get_parent() is entity:
		direction=Vector2.ZERO
