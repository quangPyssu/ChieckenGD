extends bullet

func _ready():
	BounceCount=0
	inClampedScreen=false

	super._ready()

	BaseSpeed=1000.0
	velocity=Vector2(0,BaseSpeed)
	accelaration=100
	rotation_degrees=-90

func _process(delta):
	super._process(delta)