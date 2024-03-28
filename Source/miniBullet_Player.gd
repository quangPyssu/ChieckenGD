extends bullet

func _ready():
	inClampedScreen=false
	
	HP=1
	speed=1400.0
	
	direction=Vector2(0.0,-1.0).rotated(randf_range(-PI/30,PI/30))
	rotation=direction.angle()
