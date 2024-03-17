extends bullet

func _ready():
	inClampedScreen=false
	
	HP=1
	speed=200.0

func _on_timer_timeout():
	speed*=2.5
	direction = (Global.PlayerPos - global_position).normalized()
	look_at(Global.PlayerPos)
	rotate(PI/2)
