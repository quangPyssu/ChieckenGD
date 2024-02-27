extends bullet

func _ready():
	rotation_degrees=-90
	HP = 99999999

func _process(delta):
	super._process(delta)
	var target: Array[Area2D] = get_overlapping_areas()
	
	for i in target:
		if i.get_parent().has_method("take_damage"):
			i.get_parent().take_damage(damage*delta)
			print("dm  ")
		else:
			i.HP-=damage
 
func _on_area_entered(_area:Area2D):
	pass
