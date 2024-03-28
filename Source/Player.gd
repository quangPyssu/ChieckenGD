extends entity

const BaseSpeed: float = 30000.0
const SlowPercentage: float = 0.5
const FastPercentage: float = 1.5

var AttackLoaded: bool = true
var SpecialLoaded: bool = false

var SpecialIFrame: Array[float] = [0.5,0.0,4.0,0.0]
var SpecialTimeRatio:float=0

var particle:Array[PackedScene]
var bomb:PackedScene 

var bulletCnt:int=55

signal Attack
signal Special

func _ready():
	HP = Global.maxHP
	Global.maxSP = Global.SpecialTime[Global.SpecialType]
	
	Global.SP=Global.SpecialTime[Global.SpecialType]
	Global.AP=Global.WeaponTime[Global.WeaponType]

	%AttackTimer.timeout.connect(_on_attack_timer_timeout)
	%SpecialTimer.timeout.connect(_on_special_timer_timeout)

	get_node("AnimationCenter/BattlecruiserBase").visible = true
	$AnimationCenter/Ammo.visible=false
	$AnimationCenter/Ammo2.visible=false
	loadParti()
	super._ready()

func _physics_process(delta):	
	#move the player via wasd and arrow keys	
	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	var current_speed:float = BaseSpeed
	var JetType: int = 1

	if Input.is_action_pressed("SlowMove"):
		current_speed = BaseSpeed*SlowPercentage
		JetType = 0
	elif Input.is_action_pressed("FastMove"):
		current_speed = BaseSpeed*FastPercentage
		JetType = 2

	JetAnimation(JetType)
	speed = current_speed
	
	super._physics_process(delta)
	Global.PlayerPos = global_position

func atk():
	AttackLoaded = false
	Attack.emit()
	%AttackTimer.start()
	var SpawnParticle:GPUParticles2D = particle[Global.CurrentWeapon].instantiate()
	add_child(SpawnParticle)
	SpawnParticle.position = -Vector2(0,50)
	SpawnParticle.emitting = true
	Global.AP=0.0
	recoverAP()

func _process(delta):
	Global.HP = HP
	%AttackTimer.wait_time=Global.WeaponTime[Global.EquippedWeapon[Global.CurrentWeapon]]

	if Input.is_action_pressed("Attack") and AttackLoaded:
		if Global.EquippedWeapon[Global.CurrentWeapon]!=2:
			atk()
		elif bulletCnt>0:
			atk()
			bulletCnt=max(0,bulletCnt-1)
	
	if Input.is_action_pressed("Special") and SpecialLoaded:
		SpecialLoaded = false
		SpecialAttack(Global.SpecialType)
		force_Flicker(SpecialIFrame[Global.SpecialType])
		%SpecialTimer.wait_time=Global.SpecialTime[Global.SpecialType]
		%SpecialTimer.start()
		Global.SP=0.0
		
	recoverSP(delta)
	reloadBullet()
		
func SpecialAttack(SpecialType:int):
	match SpecialType:
		0:
			_gun_shot()
		1:
			pass
		3: 
			_big_beam()

func _gun_shot():
	for i in 5:
		var shot:bullet = bomb.instantiate()
		shot.rotation=(i-2)*PI/18.0-PI/2
		shot.direction=Vector2(0,-1).rotated(shot.rotation+PI/2)
		shot.global_position=global_position+Vector2(0, -50)
		shot.get_child(shot.get_child_count()-1).volume_db-=10
		get_node("/root/Game/Projectiles").add_child(shot)

func _big_beam():
	var Beam:bullet = bomb.instantiate()
	add_child(Beam)

func _shielded():
	get_node("AnimationCenter/AnimationPlayer").play("Shielded")

func _blow_up():
	get_node("AnimationCenter/AnimationPlayer").play("Blowing")
	stopProcess()
	Global.LevelEnd = true
	Global.defeated = true
	
func changeWeapon():
	AttackLoaded = false
	%AttackTimer.wait_time=Global.WeaponTime[Global.EquippedWeapon[Global.CurrentWeapon]]
	%AttackTimer.start()
	Global.AP=0.0
	Global.maxAP=Global.WeaponTime[Global.EquippedWeapon[Global.CurrentWeapon]]
	print(Global.maxAP)
	recoverAP()

func JetAnimation(JetType: int):
	if JetType == 0:
		%FireJetFast.visible = false
		%FireJetSlow.visible = true
	else:
		%FireJetSlow.visible = false
		%FireJetFast.visible = true

		if JetType == 1:
			%FireJetFast.scale.y = 0.75
		else:
			%FireJetFast.scale.y = 1

func _on_attack_timer_timeout():
	AttackLoaded = true

func _on_special_timer_timeout():
	SpecialLoaded = true

func kill():
	if !isDead:
		super.kill()
		_blow_up()
	
func force_Flicker(flickTime:float):
	isFlickering = true
	for i:int in range(0, flickTime/0.2):
		self_modulate.a = 0.5
		await get_tree().create_timer(0.1).timeout
		self_modulate.a = 1
		await get_tree().create_timer(0.1).timeout
	isFlickering = false

func recoverSP(delta):
	if Global.SP<Global.maxSP:
		Global.SP+=delta
	
	#tween.tween_property(Global, "SP", Global.maxSP, Global.SpecialTime[Global.SpecialType]).set_trans(Tween.TRANS_LINEAR)

func recoverAP():
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(Global, "AP", Global.maxAP, Global.WeaponTime[Global.EquippedWeapon[Global.CurrentWeapon]]).set_trans(Tween.TRANS_LINEAR)

func take_damage(damage: float):
	if (isFlickering):
		return
	super.take_damage(damage)

func loadParti():
	for i in 2:
		var a:PackedScene
		match Global.EquippedWeapon[i]:
			0,1:
				a=preload("res://Asset/particle/Particle_BaseBullet.tscn")
			2:
				a=preload("res://Asset/particle/BulletShell.tscn")
				$MiniGunTimer.start()
				$AnimationCenter/Ammo.visible=true
				$AnimationCenter/Ammo2.visible=true
				
		particle.append(a)
	
	match Global.SpecialType:
		0:
			bomb=preload("res://bullet_player_normal.tscn")
		3: 
			bomb=preload("res://BigBeam_Player.tscn")

func reloadBullet():
	if (bulletCnt<28):
		$AnimationCenter/Ammo2.frame=27-bulletCnt
		$AnimationCenter/Ammo2.position.y=-$AnimationCenter/Ammo2.frame*2+24
	else:
		$AnimationCenter/Ammo.frame=55-bulletCnt
		$AnimationCenter/Ammo.position.y=-$AnimationCenter/Ammo.frame*2+24
		
func _on_mini_gun_timer_timeout():
	bulletCnt=min(55,bulletCnt+1)
