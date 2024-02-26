extends CharacterBody2D
class_name entity

@export var HP:int = 100
@export var timerStart:float = 0
@export var timerEnd:float = -1.0
@export var rotateSpeed:float = 0
@export var speed: float = 0

var direction: Vector2 = Vector2(0, 0)


var savedDirection: Vector2 = Vector2(0, 0)
var savedSpeed: float = 0
var savedPos: Vector2 = Vector2(0, 0) #destination global_position
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
	setTimer()	

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

func _set_velocity(delta:float):
	velocity = direction * speed * delta	

func entity_timeout():
	kill()

func entity_timein():
	set_process(true)
	set_physics_process(true)

	if timerEnd!=-1.0:
		await get_tree().create_timer(timerEnd).timeout
		entity_timeout()

func setTimer():
	if timerStart>0.0:
		stopProcess()
		await get_tree().create_timer(timerStart).timeout
	
	entity_timein()

func take_damage(damage:int):
	HP -= damage
	flicker()

	if HP<=0:
		kill()

func kill():
	if !isDead:
		isDead = true
		$HitBox.queue_free()
		

		stopProcess()

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

	#set to new parent
	reparent(get_tree().current_scene.get_node("Enemies"))

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
			modulate.a = 0.5
			await get_tree().create_timer(0.1).timeout
			modulate.a = 1
			await get_tree().create_timer(0.1).timeout
		isFlickering = false

func stopProcess():
	set_process(false)
	set_physics_process(false)

func _on_tree_exiting():
	if "entityCount" in get_parent():
		get_parent().entityCount-=1
		
