extends entity

const BaseSpeed: float = 30000.0
const SlowPercentage: float = 0.5
const FastPercentage: float = 1.5

var AttackLoaded: bool = true
var SpecialLoaded: bool = false

var WeaponType:int = 0
var SpecialType:int = 0

var WeaponTime: Array[float] = [1.0,0.0,0.0,0.0]
var SpecialTime: Array[float] = [5.0,0.0,0.0,0.0]

signal Attack
signal Special

func _ready():
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
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

	velocity = direction * current_speed * delta

func _process(_delta):
	super._process(_delta)
	Timers()

	if Input.is_action_pressed("Attack") and AttackLoaded:
		AttackLoaded = false
		Attack.emit(WeaponType)
		%AttackTimer.wait_time=WeaponTime[WeaponType]
		%AttackTimer.start()
	
	if Input.is_action_pressed("Special") and SpecialLoaded:
		SpecialLoaded = false
		print("Special")
		%SpecialTimer.wait_time=SpecialTime[SpecialType]
		%SpecialTimer.start()

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

func Timers():
	if %AttackTimer.is_stopped():
		AttackLoaded = true

	if %SpecialTimer.is_stopped():
		SpecialLoaded = true