extends bullet

var rot:float

func _ready():
	inClampedScreen=false
	
	HP=1
	speed=180.0
	rot=randf_range(-0.5,0.5)
	direction=(Global.PlayerPos - global_position).normalized()
	
func _physics_process(delta):
	rotation+=delta*rot

func _on_timer_timeout():
	speed*=2.5
	direction = (Global.PlayerPos - global_position).normalized()
	look_at(Global.PlayerPos)
	rotate(PI/2)
	$BulletSound.play()
