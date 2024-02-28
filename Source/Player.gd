extends entity

const BaseSpeed: float = 30000.0
const SlowPercentage: float = 0.5
const FastPercentage: float = 1.5

var AttackLoaded: bool = true
var SpecialLoaded: bool = false

var WeaponType:int = 0
var SpecialType:int = 0

var WeaponTime: Array[float] = [0.5,0.0,0.0,0.0]
var SpecialTime: Array[float] = [30,0.0,0.0,0.0]
var SpecialIFrame: Array[float] = [4,0.0,0.0,0.0]

var particle:Array[PackedScene] = [preload("res://Asset/particle/Particle_BaseBullet.tscn")]

signal Attack
signal Special

func _ready():
	
	HP = Global.HP

	%AttackTimer.timeout.connect(_on_attack_timer_timeout)
	%SpecialTimer.timeout.connect(_on_special_timer_timeout)
	print("sp ",%SpecialTimer.wait_time)

	get_node("AnimationCenter/BattlecruiserBase").visible = true

	super._ready()

func _physics_process(delta):	
	#move the player via wasd and arrow keys	

	direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	var current_speed = BaseSpeed

	var JetType: int = 1

	if Input.is_action_pressed("SlowMove"):
		current_speed = BaseSpeed*SlowPercentage
		JetType = 0
	elif Input.is_action_pressed("FastMove"):
		current_speed = BaseSpeed*FastPercentage
		JetType = 2

	JetAnimation(JetType)

	speed = current_speed

	#MOVE With engine
	super._physics_process(delta)
	Global.PlayerPos = global_position

func _process(_delta):

	Global.HP = HP

	%AttackTimer.wait_time=WeaponTime[WeaponType]

	if Input.is_action_pressed("Attack") and AttackLoaded:
		AttackLoaded = false
		Attack.emit(WeaponType)
		%AttackTimer.wait_time=WeaponTime[WeaponType]
		%AttackTimer.start()
		var SpawnParticle = particle[WeaponType].instantiate()
		add_child(SpawnParticle)
		SpawnParticle.position = -Vector2(0,50)
		SpawnParticle.emitting = true
	
	if Input.is_action_pressed("Special") and SpecialLoaded:
		SpecialLoaded = false
		var Beam = preload("res://BigBeam_Player.tscn").instantiate()
		add_child(Beam)
		force_Flicker(SpecialIFrame[SpecialType])
		%SpecialTimer.wait_time=SpecialTime[SpecialType]
		%SpecialTimer.start()
		Global.SP=0
		recoverSP()

	# +  Blow up
	if Input.is_action_pressed("TestButton+"):
		_blow_up()

	# - hurt
	if Input.is_action_just_pressed("TestButton-"):
		HP-=1			

func _shielded():
	get_node("AnimationCenter/AnimationPlayer").play("Shielded")

func _blow_up():
	get_node("AnimationCenter/AnimationPlayer").play("Blowing")
	stopProcess()
	Global.defeated = true

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
	_blow_up()
	
func force_Flicker(flickTime:float):
	isFlickering = true
	for i:int in range(0, flickTime/0.2):
		self_modulate.a = 0.5
		await get_tree().create_timer(0.1).timeout
		self_modulate.a = 1
		await get_tree().create_timer(0.1).timeout
	isFlickering = false

func recoverSP():
	var tween =get_tree().create_tween()
	tween.tween_property(Global, "SP", Global.maxSP, SpecialTime[SpecialType]).set_trans(Tween.TRANS_LINEAR)

func take_damage(damage: int):
	if (isFlickering):
		return
	super.take_damage(damage)
