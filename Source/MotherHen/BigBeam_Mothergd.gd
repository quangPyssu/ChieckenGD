extends bullet

var ani: AnimationPlayer

func _ready():
	HP = 99999999
	ani = $AnimationCenter/AnimationPlayer
	ani.play("BeamStart_Mother")
	ani.queue("Beaming_Mother")
	$BulletSound.play()
	$AnimationCenter/ChargeParticle.emitting=true
	Global.isShaking=true
	Global.shakeStrength=3

func _process(delta):
	super._process(delta)
	var target: Array[Area2D] = get_overlapping_areas()
	
	for i in target:
		if i is bullet:
			i.kill()
		else:
			i.get_parent().take_damage(damage)

	if !ani.is_playing():
		queue_free()
 
func _on_area_entered(_area:Area2D):
	pass

func _on_timer_end_timeout():
	ani.play_backwards("BeamStart_Mother")


func _on_tree_exited():
	Global.isShaking=false
