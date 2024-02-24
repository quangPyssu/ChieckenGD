extends CharacterBody2D
class_name entity

@export var HP:int = 100
@export var timerStart:float = 0
@export var timerEnd:float = -1.0

var direction: Vector2 = Vector2(0, 0)
var speed: float = 0

var savedDirection: Vector2 = Vector2(0, 0)
var savedSpeed: float = 0
var savedPos: Vector2 = Vector2(0, 0) #destination position
var isGoing: bool = false

@export var inClampedScreen: bool = true
@export var BounceOffSceen: bool = true
@export var canFlicker: bool = true
var isFlickering: bool = false

var StartClock:Timer = null
var EndClock:Timer = null

func _ready():
	setTimer()
	print("entity ready")

func _physics_process(delta):
	_set_velocity(delta)
	move_and_slide()

	#if going to a position 
	if isGoing:
		Going()
	else :
		if inClampedScreen: #clamp in the screen		
			#Bounce off the screen
			if BounceOffSceen:
				if position.x <= 0 or position.x >= get_viewport().size.x:
					direction.x = -direction.x
				if position.y <= 0 or position.y >= get_viewport().size.y:
					direction.y = -direction.y

		position.x = clamp(position.x, 0, get_viewport().size.x)
		position.y = clamp(position.y, 0, get_viewport().size.y)

func _process(_delta):
	pass

func _set_velocity(delta:float):
	velocity = direction * speed * delta	

func _on_entity_timeout():
	print("entity timeout")
	kill()

func _on_entity_timein():
	print("entity timein")
	
	if StartClock!=null:
		StartClock.queue_free()

	if EndClock!=null:
		EndClock.start()

func setTimer():
	if timerEnd!=-1.0:
		EndClock = Timer.new()
		EndClock.set_wait_time(timerEnd)
		EndClock.set_one_shot(true)
		EndClock.timeout.connect(_on_entity_timeout)
		add_child(EndClock)

	if timerStart>0.0:
		StartClock = Timer.new()
		StartClock.set_wait_time(timerStart)
		StartClock.set_one_shot(true)
		StartClock.timeout.connect(_on_entity_timein)
		add_child(StartClock)
		StartClock.start()
	else:
		_on_entity_timein()

func take_damage(damage:int):
	HP -= damage
	print("entity take damage: ", HP)
	flicker()

	if HP<=0:
		kill()

func kill():
	print("entity kill")
	#stop process and physics
	set_process(false)
	set_physics_process(false)

	var killFlag:bool = false

	for i in $AnimationCenter.get_children():
		if i.has_method("kill"):
			i.kill()
			killFlag = true
	
	if killFlag==false:
		queue_free()

func _on_animation_center_tree_exited():
	queue_free()

func gotoPosition(pos:Vector2,NewSpeed:float):
	#save direction and speed 
	#then move to the new position 
	savedDirection = direction
	savedSpeed = speed
	savedPos = pos
	speed = NewSpeed

	isGoing = true

func Going():
	if position.distance_to(savedPos) < 30:
		isGoing = false
		direction = savedDirection
		speed = savedSpeed
	else:
		direction = (savedPos - position).normalized()
		speed = savedSpeed

func flicker():
	#flicker the entity with the modulate
	if canFlicker and !isFlickering:
		isFlickering = true
		for i in range(0, 10):
			modulate.a = 0.5
			await get_tree().create_timer(0.1).timeout
			modulate.a = 1
			await get_tree().create_timer(0.1).timeout
