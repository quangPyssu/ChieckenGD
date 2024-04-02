extends entity

var preEgg:PackedScene = preload("res://UFOBullet.tscn")
var preLas:PackedScene = preload("res://SmallBeam_Enemy.tscn")

var feather:PackedScene = preload("res://Asset/particle/Particle_Glass.tscn")

var attackRange:int = 1

func atThreeQuarterHealth():
	$Explosion.play("explosion")
	$LaserTimer.wait_time=3.5
	$LaserTimer.start()
	$Audio.stream=preload("res://Asset/Sounds/PlayerExplode.ogg")
	$Audio.play()
	$AnimationCenter/AnimationPlayer.speed_scale=1.5
	speed=15000
	
func atHalfHealth():
	$Audio.stream=preload("res://Asset/Sounds/PlayerExplode.ogg")
	$Audio.play()
	$Explosion.play("explosion")
	$LaserTimer.wait_time=3.0
	$LaserTimer.start()
	$AnimationCenter/Ufo0.visible = false
	$AnimationCenter/Ufo1.visible = true
	$AttackTimer.wait_time=2.0
	$AnimationCenter/AnimationPlayer.speed_scale=2
	speed=20000
	spawnFea()

func atQuarterHealth():
	attackRange=0
	$AttackTimer.wait_time=2.3
	$AttackTimer.start()
	$LaserTimer.wait_time=2.5
	$LaserTimer.start()
	direction=Vector2(0.0,0.0)
	$AnimationCenter/AnimationPlayer.speed_scale=3
	gotoPosition(Vector2(Global.ScreenSize.x/2,Global.ScreenSize.y/3),30000)
	$Audio.stream=preload("res://Asset/Sounds/PlayerExplode.ogg")
	$Audio.play()
	$Audio2.stream=preload("res://Asset/Sounds/engineUfoDamaged.ogg")
	$Audio2.play()
	$Explosion.play("explosion")
	
func _process(_delta):
	pass

func SpecialA():
	for i in 2:
		var rot:float=float(randi()%36)
		for j in 12:
			var Egg=preEgg.instantiate()
			add_child(Egg)
			var deg:float = j*30.0+rot
			Egg.rotation_degrees=deg+90.0
			Egg.global_position = $Marker2.global_position
			Egg.direction=Vector2(1,0).rotated(deg_to_rad(deg))
			Egg.get_child(2).volume_db=-10
			await get_tree().create_timer(0.05).timeout
		await get_tree().create_timer(0.55).timeout

func spawnFea():
	var f = feather.instantiate()
	f.global_position = $Marker.global_position
	get_node("/root/Game/Projectiles").add_child(f)
	
func kill():
	if !isDead:
		super.kill()
		$Audio.stream=preload("res://Asset/Sounds/PlayerExplode.ogg")
		$Audio.play()
		$Audio2.stop()
		$AttackTimer.stop()
		$LaserTimer.stop()
		
		$AnimationCenter.visible=0
		$Explosion.play("explosion")
		spawnFea()
		spawnFea()
		var f = preload("res://Asset/particle/Particle_Debirs.tscn").instantiate()
		f.global_position = global_position
		get_node("/root/Game/Projectiles").add_child(f)

		await get_tree().create_timer(2).timeout
		queue_free()

func attack():
	var Egg=preEgg.instantiate()
	get_node("/root/Game/Projectiles").add_child(Egg)
	Egg.global_position = global_position


func _on_attack_timer_timeout():
	if !attackRange:
		SpecialA()
	else:
		attack()

func _on_laser_timer_timeout():
	var b = preLas.instantiate()
	b.global_position.x=Global.PlayerPos.x
	b.global_position.y=-1
	get_node("/root/Game/Projectiles").add_child(b)
