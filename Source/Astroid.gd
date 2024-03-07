extends bullet

func _ready():
	inClampedScreen=false
	
	var ran:float = randf_range(0.7,1.2)
	speed=200.0/ran
	rotation_degrees=ran*90
	%AnimationCenter.get_node("AnimationPlayer").speed_scale=ran
	scale=Vector2(ran,ran)


func kill():
	$HitBox.queue_free()
	%AnimationCenter/AnimationPlayer.play("Explosion")
