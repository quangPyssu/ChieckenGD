extends bullet

func _ready():
	BounceCount=0
	inClampedScreen=false

	super._ready()

	BaseSpeed=300.0
	direction=Vector2(0,1)
	accelaration=0
    