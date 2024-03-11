extends CharacterBody2D
class_name entity

@export var HP:float = 100.0
var MaxHP:float 
@export var timerEnd:float = -1.0
@export var rotateSpeed:float = 0
@export var speed: float = 0

var savedDirection: Vector2 = Vector2(0, 0)
var savedSpeed: float = 0
@export var direction: Vector2 = Vector2(0, 0)
@export var savedPos: Vector2 = Vector2(0, 0) #destination global_position
@export var isInvincible=false
var isGoing: bool = false
var isDead: bool = false

var ShapeSize:Vector2 = Vector2(0, 0) 
var gotShapeSize:bool = false

@export var inClampedScreen: bool = true
@export var BounceOffSceen: bool = true
@export var canFlicker: bool = true
var isFlickering: bool = false
@export var flickerTime: float = 1.0

func _ready():
	MaxHP = HP
	
	if (timerEnd!=-1):
		HP=timerEnd

	if savedPos!=Vector2(0, 0):
		#print ("gotoPosition ", savedPos, " speed ", speed)
		gotoPosition(savedPos, speed)

func _physics_process(delta):
	_set_velocity(delta)
	move_and_slide()
	rotation_degrees += rotateSpeed

	#if going to a global_position 
	if isGoing:
		Going()
	else :
		if inClampedScreen: #clamp in the screen		
			#Bounce off the screen
			if !gotShapeSize:
				gotShapeSize = true
				ShapeSize = $PhysicBox.shape.get_rect().size/2

			if BounceOffSceen:

				if global_position.x - ShapeSize.x <= 0 or global_position.x + ShapeSize.x>= get_viewport().size.x:
					direction.x = -direction.x
				if global_position.y - ShapeSize.y <= 0 or global_position.y + ShapeSize.y>= get_viewport().size.y:
					direction.y = -direction.y					

			global_position.x = clamp(global_position.x , 0, get_viewport().size.x)
			global_position.y = clamp(global_position.y , 0, get_viewport().size.y)

	if timerEnd!=-1.0:
		HP-=delta
		if HP<=0:
			queue_free()

func _set_velocity(delta:float):
	velocity = direction * speed * delta	

func entity_timeout():
	kill()

func take_damage(damage:int):
	if isInvincible:
		return
	#at three quarter health
	var damed: float = HP - damage
	if HP > MaxHP * 3 / 4 and damed <= MaxHP * 3 / 4:
		atThreeQuarterHealth()
	elif HP > MaxHP / 2 and damed <= MaxHP / 2:
		atHalfHealth()
	elif HP > MaxHP / 4 and damed <= MaxHP / 4:
		atQuarterHealth()

	HP = damed
	flicker()

	if HP<=0:
		kill()

func atThreeQuarterHealth():
	pass

func atHalfHealth():
	pass

func atQuarterHealth():
	pass	

func kill():
	isDead = true
	$HitBox.queue_free()

	stopProcess()

func _on_animation_center_tree_exited():
	queue_free()

func gotoPosition(pos:Vector2,NewSpeed:float):
	savedDirection = direction
	savedSpeed = speed
	savedPos = pos
	speed = NewSpeed

	isGoing = true	

func Going():
	if global_position.distance_to(savedPos) < 30:
		isGoing = false
		direction = savedDirection
		speed = savedSpeed
	else:
		direction = (savedPos - global_position).normalized()

func flicker():
	#flicker the entity with the modulate
	if canFlicker and !isFlickering:
		isFlickering = true
		for i:int in range(0, flickerTime/0.2):
			$AnimationCenter.modulate.a = 0.5
			await get_tree().create_timer(0.1).timeout
			$AnimationCenter.modulate.a = 1
			await get_tree().create_timer(0.1).timeout
		isFlickering = false

func stopProcess():
	set_process(false)
	set_physics_process(false)

func _on_tree_exiting():
	if "entityCount" in get_parent():
		get_parent().entityCount-=1
