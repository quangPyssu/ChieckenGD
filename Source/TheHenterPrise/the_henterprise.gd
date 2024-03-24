extends entity

var preEss:PackedScene = preload("res://SmallBeam_Enemy.tscn")
var preEgg:PackedScene = preload("res://SunBall.tscn")
var preEee:PackedScene = preload("res://TaperBeam.tscn")
var preBaked:PackedScene = preload("res://ElectroBeam.tscn")

var preEdd:PackedScene = preload("res://UFOBullet.tscn")

var attackRange:int = 0

var lockedMode:bool=false
var blastScale:float = 1
var damage:float = 30

var orgOrgPos:Vector2
var orgPos:Vector2 
var curPos:Vector2

func _ready():
	scale=Vector2(1.0,1.0)
	super._ready()
	$Audio.play()
	orgPos=savedPos
	orgOrgPos=savedPos
	
	await get_tree().create_timer(5.0).timeout 
	Beam()

func _process(delta):
	if Input.is_action_just_pressed("TestButton+"):
		Beam()
	
	if Input.is_action_just_pressed("TestButton-"):
		Sun()
		
	if Input.is_action_just_pressed("FramShow"):
		laserStraight()
		
	if Input.is_action_just_pressed("ChangeWeapon"):
		laserTap()
	
func atThreeQuarterHealth():
	attackRange=1
	direction=Vector2.ZERO
	gotoPosition(global_position+Vector2(randi_range(-30,30),-70),13000)
	$Audio.play()
	
	blastScale=2
	BackUp()
	
func atHalfHealth():
	attackRange=2
	$Audio.play()
	
	blastScale=3
	BackUp()

func atQuarterHealth():
	attackRange=3
	$Audio.play()
	$AttackTimer.wait_time=6
	blastScale=5
	BackUp()
	
func Beam():
	var Egg:bullet = preBaked.instantiate()
	Egg.rotation+=PI/2
	Egg.blastScale=blastScale
	Egg.global_position=$AnimationCenter/HenterpriseBack/BeamPos.global_position
	$AnimationCenter/HenterpriseBack.add_child(Egg)
	
func Sun():
	var Egg:bullet = preEgg.instantiate()
	Egg.look_at(Global.PlayerPos)
	Egg.global_position=global_position
	%Bullets.add_child(Egg)

func laserStraight():
	for i in $AnimationCenter/HenterpriseBack/Mark.get_children():
		var Egg:bullet = preEss.instantiate()
		Egg.get_child(Egg.get_child_count()-1).volume_db-=4
		i.add_child(Egg)
		await get_tree().create_timer(0.5).timeout
	
func laserTap():
	for i in $AnimationCenter/HenterpriseBack/Mark.get_children():
		var Egg:bullet = preEee.instantiate()
		Egg.rotation=randf_range(-PI/3,PI/3)+PI/2
		Egg.get_child(Egg.get_child_count()-1).volume_db-=20
		i.add_child(Egg)

func kill():
	if !isDead:
		isDead = true

		stopProcess()

		await get_tree().create_timer(2).timeout
		queue_free()

func _on_hit_box_area_entered(area):
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
	
func attack():
	match attackRange:
		0:
			for i in 2:
				laserStraight()
				await get_tree().create_timer(2.0).timeout
		1:
			for i in 2:
				laserTap()
				await get_tree().create_timer(0.5).timeout
		2:
			for i in 3:
				laserTap()
				await get_tree().create_timer(0.5).timeout
		3:
			laserTap()
			for i in 2:
				Sun()
				await get_tree().create_timer(1.5).timeout

func _on_attack_timer_timeout():
	if !lockedMode:
		attack()

func BackUp():
	isInvincible=true
	lockedMode=true
	direction=Vector2.ZERO
	gotoPosition(orgOrgPos+Vector2(0,-600),10000)
	CleanAttack()
	
	await get_tree().create_timer(4.4).timeout
	CleanAttack()
	
	match attackRange:
		1:
			rotation=-PI/2
			global_position=Vector2(-354.0,490.0)
			direction=Vector2.ZERO
			gotoPosition(global_position+Vector2(400,0.0),10000)
			
			await get_tree().create_timer(2).timeout
			Beam()
			await get_tree().create_timer(2).timeout
			attack()
			await get_tree().create_timer(5).timeout
			
			direction=Vector2.ZERO
			gotoPosition(global_position-Vector2(400,0.0),10000)

		2:
			rotation=deg_to_rad(-205.3)
			global_position=Vector2(1920.0,1408.0)
			direction=Vector2.ZERO
			gotoPosition(Vector2(1352.0,1078.0),10000)
			
			await get_tree().create_timer(2).timeout
			Beam()
			await get_tree().create_timer(3).timeout
			attack()
			await get_tree().create_timer(6).timeout
			
			direction=Vector2.ZERO
			gotoPosition(Vector2(1920.0,1408.0),13000)

		3:
			rotation=PI
			global_position=Vector2(250.0,1396.0)
			direction=Vector2.ZERO
			gotoPosition(Vector2(1400.0,1000.0),4000)
			
			await get_tree().create_timer(2).timeout
			Beam()
			await get_tree().create_timer(3).timeout
			attack()
			await get_tree().create_timer(10).timeout
			
			direction=Vector2.ZERO
			gotoPosition(Vector2(1400.0,1396.0),10000)

	await get_tree().create_timer(2.5).timeout
	goIn()
	
func goIn():
	rotation=0
	global_position=Vector2(960.0,-335.0)
	direction=Vector2.ZERO
	gotoPosition(orgOrgPos,10000)
	lockedMode=false
	isInvincible=false

func CleanAttack():
	for i in $AnimationCenter/HenterpriseBack/Mark.get_children():
		for j in i.get_children():
			j.queue_free()

func _on_attack_timer_2_timeout():
	
	for i in %UfoZone.get_children():
		for j in 3:
			var ranPos=Vector2(randf_range(i.get_child(1).global_position.x,i.get_child(0).global_position.x),
randf_range(i.get_child(1).global_position.y,i.get_child(0).global_position.y)) 
		
			var A:bullet = preEdd.instantiate()
			get_node("/root/Game/Projectiles").add_child(A)
			A.get_child(A.get_child_count()-1).volume_db-=25
			A.direction=Vector2(0,1).rotated(rotation)
			A.global_position = ranPos
			A.rotation=A.direction.angle()+PI/2.0
