extends entity

var preEgg:PackedScene = preload("res://Egg.tscn")
var feather:PackedScene = preload("res://Asset/particle/Particle_Feather.tscn")

func atThreeQuarterHealth():
	$AnimationCenter/Explosion.play("explosion")
	spawnFea()
	
	
func atHalfHealth():
	$AnimationCenter/Explosion.play("explosion")
	$AnimationCenter/BossChickenBody.visible = false
	$AnimationCenter/BossChickenBody2.visible = true	
	spawnFea()

func atQuarterHealth():
	$AnimationCenter/Explosion.play("explosion")
	$AnimationCenter/BossChickenBody2.visible = false
	$AnimationCenter/BossChickenBody3.visible = true
	spawnFea()

func spawnFea():
	var f = feather.instantiate()
	f.global_position = global_position
	get_node("/root/Game/Projectiles").add_child(f)
	
func kill():
	if !isDead:
		isDead = true

	$HitBox.queue_free()
	stopProcess()
	
	$AnimationCenter/Explosion.play("explosion")
	
	await get_tree().create_timer(0.7).timeout
	queue_free()
