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
var WeaponParticle:Array[GPUParticles2D] = []

signal Attack
signal Special

func _ready():
	super._ready()

	%AttackTimer.timeout.connect(_on_attack_timer_timeout)
	%SpecialTimer.timeout.connect(_on_special_timer_timeout)

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
		WeaponParticle.append(SpawnParticle)
	
	if Input.is_action_pressed("Special") and SpecialLoaded:
		SpecialLoaded = false
		print("Special")
		$AnimationCenter/PLayerShield.visible = 1
		%SpecialTimer.wait_time=SpecialTime[SpecialType]
		%SpecialTimer.start()

	if WeaponParticle.size()>0:
		CleanAttackParticle()

func CleanAttackParticle():
	# for with index
	for i in WeaponParticle.size()-1:
		if WeaponParticle[i].emitting==false:
			WeaponParticle[i].queue_free()
			WeaponParticle.remove_at(i)

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
