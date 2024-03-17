extends entity

var feather:PackedScene = preload("res://Asset/particle/Particle_Feather.tscn")

func atThreeQuarterHealth():
	spawnFea()
	
func atHalfHealth():
	spawnFea()

func atQuarterHealth():
	spawnFea()
	
func spawnFea():
	var f = feather.instantiate()
	f.global_position = global_position
	get_node("/root/Game/Projectiles").add_child(f)
func kill():
	if !isDead:
		super.kill()
	
		$AnimationCenter.visible=0
		spawnFea()
		spawnFea()

		await get_tree().create_timer(2).timeout
		queue_free()
