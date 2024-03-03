extends entity

var preEgg:PackedScene = preload("res://Egg.tscn")
var preSwarm:PackedScene = preload("res://bullet_anchor.tscn")
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
	f.global_position = $Marker.get_child(randi()%3).global_position
	get_node("/root/Game/Projectiles").add_child(f)
	
func kill():
	if !isDead:
		isDead = true

	$HitBox.queue_free()
	stopProcess()
	
	$AnimationCenter/Explosion.play("explosion")
	spawnFea()
	spawnFea()
	
	await get_tree().create_timer(0.7).timeout
	queue_free()

func attack(type:int):
	match type:
		1:
			for i:int in 10:
				var b:bullet = preEgg.instantiate()
				
				get_node("/root/Game/Projectiles").add_child(b)
				
				b.global_position=$Marker/AttackHole.global_position
				b.look_at(Global.PlayerPos)
				b.rotation_degrees -=90
				b.direction=Vector2(Global.PlayerPos-b.global_position).normalized()
				b.speed = 800
				
				await get_tree().create_timer(0.1).timeout
		0:
			for i:int in 2:
				var s:entity = preSwarm.instantiate()
				var num:float =randf_range(50.0,100.0)
				s._Rready(Global.SpawnType.Egg,Global.patternType.CircleShape,10.0,num,10)
				
				get_node("/root/Game/Projectiles").add_child(s)
				
				s.global_position=$Marker/AttackHole.global_position
				s.look_at(Global.PlayerPos)
				s.rotation_degrees -=90
				s.rotateSpeed=1
				s.direction=Vector2(Global.PlayerPos-s.global_position).normalized()
				s.speed = 10000
				
				await get_tree().create_timer(1).timeout
		2:
			pass

func _on_attack_timer_timeout():
	attack(randi()%2)
