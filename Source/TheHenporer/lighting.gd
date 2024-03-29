extends bullet

var rotSpeed:float=0.7

func _ready():
	HP = 99999999
	$BulletSound.play()	
	
	await get_tree().create_timer(6.5).timeout
	queue_free()

func _process(delta):
	super._process(delta)
	var target: Array[Area2D] = get_overlapping_areas()
	
	for i in target:
		if i is bullet:
			i.kill()
		else:
			i.get_parent().take_damage(damage)
			
	rotation+=delta*rotSpeed
 
func _on_area_entered(_area:Area2D):
	pass
