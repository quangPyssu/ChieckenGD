extends entity

var Ani:AnimationPlayer 

var preEss:PackedScene = preload("res://Egg.tscn")
var preBaked:PackedScene = preload("res://the_Sky_Descend.tscn")
var preSwarm:PackedScene = preload("res://bullet_anchor.tscn")

var Rot=0.7

var attackRange:int = 0

func _ready():
	super._ready()
	Ani=$AnimationCenter/Animation
	$AttackTimer.start()
	
	for i in $Node.get_children():
		i.isSpawning=false	
	$Node/SpawnerHead.isSpawning=true
	

func the_Sky_Descend():
	Ani.play("Henporer_The_Sky_Descend")
	Ani.queue("Henporer_flap")
	
	await get_tree().create_timer(0.65).timeout

	var egg:bullet=preBaked.instantiate()
	get_node("/root/Game/Projectiles").add_child(egg)
	egg.position=Global.PlayerPos
	
func EggFlower():
	var s:entity = preSwarm.instantiate()
	var num:float =randf_range(50.0,100.0)
	s._Rready(Global.SpawnType.Egg,Global.patternType.CircleShape,10.0,num,10)
				
	get_node("/root/Game/Projectiles").add_child(s)
				
	s.global_position=global_position
	s.look_at(Global.PlayerPos)
	s.rotation_degrees -=90
	s.rotateSpeed=1
	s.direction=Vector2(Global.PlayerPos-s.global_position).normalized()
	s.speed = 16000
	
func _process(_delta):
	if Input.is_action_just_pressed("TestButton+"):
		the_Sky_Descend()
		
	if Input.is_action_just_pressed("TestButton-"):
		pass

func atThreeQuarterHealth():
	attackRange=1
	
	$Node/SpawnerHead.isSpawning=false
	$Node/LaserSpawn.isSpawning=true

func atHalfHealth():
	attackRange=2
	call_deferred("the_Sky_Descend")
	$AttackTimer.wait_time=12
	$AttackTimer.start()

	$Node/LaserSpawn.isSpawning=false
	$Node/SideSpawner.isSpawning=true
	$Node/SideSpawner2.isSpawning=true

func atQuarterHealth():
	call_deferred("the_Sky_Descend")
	attackRange=3
	$AttackTimer.wait_time=15
	$AttackTimer.start()
	await get_tree().create_timer(7).timeout
	call_deferred("the_Sky_Descend")

func kill():
	if !isDead:
		isDead = true
		$AttackTimer.stop()
		stopProcess()

		await get_tree().create_timer(2).timeout
		queue_free()

func attack():
	match attackRange:
		0:
			EggFlower()
		1:
			EggFlower()
			await get_tree().create_timer(5).timeout
			EggFlower()
		2:
			the_Sky_Descend()
		3:
			EggFlower()
			the_Sky_Descend()
			await get_tree().create_timer(6).timeout
			EggFlower()
			the_Sky_Descend()

func _on_attack_timer_timeout():
	attack()
