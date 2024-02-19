extends entity

const BaseSpeed: float = -300.0

func _ready():
	super._ready()
	velocity=Vector2(0,BaseSpeed)
	inClampedScreen=false

func _process(delta):
	velocity.y+=BaseSpeed*delta