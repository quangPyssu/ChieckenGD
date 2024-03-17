extends entity

func _ready():
	super._ready()
	isInvincible=true

func _on_mother_sheel_tree_exiting():
	isInvincible=false

var preEgg:PackedScene = preload("res://BlueZig.tscn")
var preSwarm:PackedScene = preload("res://bullet_anchor.tscn")
var feather:PackedScene = preload("res://Asset/particle/Particle_Feather.tscn")
const visionBox:Vector2 = Vector2i(600.0,600.0)
const eyeBox:Vector2 = Vector2i(90.0,90.0)
var eyePos:Vector2 = Vector2i(0.0,0.0)
var eyeSpeed:float = 40
var rotationSpeed:float = 0

var attackRange:int = 1

func _process(delta):
	_look_at_player(delta)
	if !isGoing:
		var ran:int = randi()%5
		
		if !ran: rotationSpeed=0
		
		rotationSpeed+=randf_range(-0.02,0.02)*PI
		if global_position.x+300 > Global.ScreenSize.x or global_position.x<300:
			rotationSpeed=PI/4
			if global_position.y+150 > Global.ScreenSize.y  or global_position.y<0:
				rotationSpeed=PI/8
		if global_position.y+150 > Global.ScreenSize.y  or global_position.y<0:
			rotationSpeed=PI/4
		rotation+=rotationSpeed*delta
		
		direction=Vector2(1.0,0.0).rotated(rotation-PI/2.0)
	
	
func atThreeQuarterHealth():
	attackRange=2
	$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	$Audio.play()
	spawnFea()
	
func atHalfHealth():
	$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	$Audio.play()
	$AnimationCenter/BossChickenBody.visible = false
	$AnimationCenter/BossChickenBody2.visible = true	
	spawnFea()

func atQuarterHealth():
	$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	$Audio.play()
	$AnimationCenter/BossChickenBody2.visible = false
	$AnimationCenter/BossChickenBody3.visible = true
	spawnFea()
	call_deferred("SpecialA")

func SpecialA():
	pass
	
func spawnFea():
	var f = feather.instantiate()
	f.global_position = global_position
	get_node("/root/Game/Projectiles").add_child(f)
	
func kill():
	if !isDead:
		super.kill()
	
		$AnimationCenter.visible=0
		spawnFea()
		spawnFea()

		await get_tree().create_timer(2).timeout
		queue_free()

func attack(type:int):
	var cnt: int=5
	for j in cnt:
		var Egg=preEgg.instantiate()
		get_node("/root/Game/Projectiles").add_child(Egg)
		var deg:float = j*PI*2/cnt
		Egg.global_position = $HitBox.global_position
		Egg.direction=Vector2(1,0).rotated($HitBox.rotation+deg)
		Egg.rotation=Egg.direction.angle()+PI/2
		Egg.get_child(2).volume_db=-10
		await get_tree().create_timer(0.03).timeout 

func _on_attack_timer_timeout():
	attack(randi()%attackRange)
	
func flicker():
	if canFlicker and !isFlickering:
		isFlickering = true
		$AnimationCenter/AnimationPlayer.play("EggHurt")
		await get_tree().create_timer(0.1).timeout
		isFlickering = false
	
func _look_at_player(delta):
	var lookAt:Vector2 = ((Vector2(Global.PlayerPos - global_position)/visionBox).normalized()*eyeBox).rotated(rotation)
	
	if eyePos.x<lookAt.x:
		eyePos.x=eyePos.x+delta*eyeSpeed
	elif eyePos.x>lookAt.x:
		eyePos.x=eyePos.x-delta*eyeSpeed
		
	if eyePos.y<lookAt.y:
		eyePos.y=eyePos.y+delta*eyeSpeed
	elif eyePos.y>lookAt.y:
		eyePos.y=eyePos.y-delta*eyeSpeed
	
	$HitBox.position=eyePos
	$HitBox.look_at(Global.PlayerPos)
	$HitBox.rotation-=PI/2.0
	
