extends entity

func _ready():
	scale=Vector2(1.0,1.0)
	super._ready()

var preEgg:PackedScene = preload("res://BlueZig.tscn")
var preBaked:PackedScene = preload("res://ElectroBeam.tscn")

var attackRange:int = 1

var lockedMode:bool=false

func _process(delta):
	if Input.is_action_just_pressed("TestButton+"):
		Beam()
	
func atThreeQuarterHealth():
	attackRange=2
	$Audio.play()
	
func atHalfHealth():
	attackRange=3
	$Audio.play()

func atQuarterHealth():
	$Audio.play()

func SpecialA():
	pass
	
func Beam():
	var Egg:bullet = preBaked.instantiate()
	Egg.rotation+=PI/2
	$AnimationCenter/HenterpriseBack.add_child(Egg)
	
	
func kill():
	if !isDead:
		isDead = true

		stopProcess()

		await get_tree().create_timer(2).timeout
		queue_free()
		
func flicker():
	if canFlicker and !isFlickering:
		isFlickering = true
		await get_tree().create_timer(0.1).timeout
		isFlickering = false	

