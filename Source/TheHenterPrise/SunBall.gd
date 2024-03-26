extends bullet

var rot:float

func _ready():
	inClampedScreen=false
	
	HP=1
	speed=180.0
	rot=randf_range(-0.5,0.5)
	direction=(Global.PlayerPos - global_position).normalized()
	Global.shakeStrength+=3
	await get_tree().create_timer(0.7).timeout
	Global.shakeStrength-=3
	
func _physics_process(delta):
	rotation+=delta*rot
