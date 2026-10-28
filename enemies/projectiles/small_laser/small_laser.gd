extends bullet

var ani: AnimationPlayer

func _ready():
	HP = 99999999
	ani = $AnimationCenter/AnimationPlayer
	ani.play("default")

func _process(delta):
	super._process(delta)
	var target: Array[Area2D] = get_overlapping_areas()
	
	for i in target:
		if i is bullet:
			continue
		else:
			i.get_parent().take_damage(damage*delta)

	if !ani.is_playing():
		queue_free()
