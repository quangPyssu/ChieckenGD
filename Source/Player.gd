extends entity

const BaseSpeed: float = 30000.0
const SlowPercentage: float = 0.5
const FastPercentage: float = 1.5

var AttackLoaded: bool = true
var SpecialLoaded: bool = false

var WeaponType:int = 0
var SpecialType:int = 0

var WeaponTime: Array[float] = [0.5,0.0,0.0,0.0]
var SpecialTime: Array[float] = [5.0,0.0,0.0,0.0]

var particle:Array[PackedScene] = [preload("res://Asset/particle/Particle_BaseBullet.tscn")]

signal Attack
signal Special

func _ready():
	super._ready()
	HP = Global.HP

	%AttackTimer.timeout.connect(_on_attack_timer_timeout)
	%SpecialTimer.timeout.connect(_on_special_timer_timeout)

	get_node("AnimationCenter/BattlecruiserBase").visible = true

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

func _process(_delta):

	Global.HP = HP
	super._process(_delta)

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
		print("Special")
		$AnimationCenter/PLayerShield.visible = 1
		%SpecialTimer.wait_time=SpecialTime[SpecialType]
		%SpecialTimer.start()
		Global.SP=0
		recoverSP()

	# +  Blow up
	if Input.is_action_pressed("TestButton+"):
		_blow_up()
		#kill()

	# - hurt
	if Input.is_action_just_pressed("TestButton-"):
		HP-=1	
		

func _shielded():
	get_node("AnimationCenter/AnimationPlayer").play("Shielded")

func _blow_up():
	get_node("AnimationCenter/AnimationPlayer").play("Blowing")
	#stop process and physics process
	set_process(false)
	set_physics_process(false)
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


func recoverSP():
	var tween =get_tree().create_tween()
	tween.tween_property(Global, "SP", Global.maxSP, 10).set_trans(Tween.TRANS_LINEAR)