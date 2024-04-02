extends bullet

func _ready():
	inClampedScreen=false
	
	var ran:float = randf_range(0.7,1.2)
	speed=200.0/ran
	rotation_degrees=randf_range(0.0,1)*90.0
	%AnimationCenter.get_node("AnimationPlayer").speed_scale=ran*randf_range(0.9,1)/randf_range(0.8,1)
	scale=Vector2(ran,ran)


func kill():
	$HitBox.queue_free()
	%AnimationCenter/AnimationPlayer.play("Explosion")
