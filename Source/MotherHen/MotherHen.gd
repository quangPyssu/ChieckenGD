extends entity

func _ready():
	scale=Vector2(1.0,1.0)
	super._ready()

var preEss:PackedScene = preload("res://UFOBullet.tscn")
var preEgg:PackedScene = preload("res://BlueZig.tscn")
var preBaked:PackedScene = preload("res://BigBeam_Mother.tscn")

const visionBox:Vector2 = Vector2i(600.0,600.0)
const eyeBox:Vector2 = Vector2i(90.0,90.0)
var eyePos:Vector2 = Vector2i(0.0,0.0)
var eyeSpeed:float = 40
var rotationSpeed:float = 0
var eyeRoationSpeed:float = PI/4.0

var attackRange:int = 1

var lockedMode:bool=false

func _process(delta):
	
	if (lockedMode):
		$HitBox.rotation+=eyeRoationSpeed*delta
		$Beam.position=$HitBox.position
		$Beam.rotation=$HitBox.rotation+PI/2
	else:
		_look_at_player(delta)
		if !isGoing:
			var ran:int = randi()%5
			
			if !ran: rotationSpeed=0
			
			rotationSpeed+=randf_range(-0.02,0.02)*PI
			if global_position.x+300 > Global.ScreenSize.x or global_position.x<300:
				rotationSpeed=PI/4
				if global_position.y+500 > Global.ScreenSize.y  or global_position.y<0:
					rotationSpeed=PI/8
			if global_position.y+500 > Global.ScreenSize.y  or global_position.y<0:
				rotationSpeed=PI/4
			rotation+=rotationSpeed*delta
			
			direction=Vector2(1.0,0.0).rotated(rotation-PI/2.0)
	
func atThreeQuarterHealth():
	attackRange=2
	$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	$Audio.play()
	
func atHalfHealth():
	attackRange=3
	$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	$Audio.play()

func atQuarterHealth():
	$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	$Audio.play()
	call_deferred("SpecialA")

func SpecialA():
	$Audio.stream=preload("res://Asset/Sounds/chargeWarning.ogg")
	$Audio.play()
	attackRange=4
	direction=Vector2(0,0)
	lockedMode=true
	gotoPosition(Global.ScreenSize/2.0,10000.0)
	
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", 0, 2.0).set_trans(Tween.TRANS_LINEAR)
	await get_tree().create_timer(2.5).timeout 
	
	Beam()
	$AttackTimer2.start()
	
func kill():
	if !isDead:
		isDead = true
	
		$AttackTimer.stop()
		$AttackTimer2.stop()
		stopProcess()
	
		$AnimationCenter/AnimationPlayer.play("kill")

		await get_tree().create_timer(2).timeout
		queue_free()

func TrackShot(cnt: int):
	for j in cnt:
		var Egg=preEgg.instantiate()
		get_node("/root/Game/Projectiles").add_child(Egg)
		var deg:float = j*PI*2/cnt
		Egg.global_position = $HitBox.global_position
		Egg.direction=Vector2(1,0).rotated($HitBox.rotation+deg)
		Egg.rotation=Egg.direction.angle()+PI/2
		Egg.get_child(2).volume_db=-10
		await get_tree().create_timer(0.03).timeout 
		
func SpreadShot(cnt:int,mul:int):
	var hCnt:int = cnt/2
	for i in mul:
		for j in cnt:
			var Egg=preEss.instantiate()
			get_node("/root/Game/Projectiles").add_child(Egg)
			Egg.global_position = $HitBox.global_position
			
			var deg:float = (j-hCnt)*PI/2.0/cnt+Egg.get_angle_to(Global.PlayerPos)
			Egg.direction=Vector2(1,0).rotated(deg)
			Egg.rotation=Egg.direction.angle()+PI/2
			Egg.get_child(2).volume_db=-10
			await get_tree().create_timer(0.03).timeout 
		await get_tree().create_timer(0.5).timeout 
		
func Beam():
	var begg=preBaked.instantiate()
	$Beam.add_child(begg)

func attack():
	match attackRange:
		1:
			SpreadShot(8,2)
		2:
			TrackShot(5)
		3: 
			SpreadShot(4,3)
			TrackShot(5)
		4:
			SpreadShot(5,2)
			TrackShot(3)

func _on_attack_timer_timeout():
	attack()
	
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
	$HitBox.rotation-=PI/2

func _on_attack_timer_2_timeout():
	eyeRoationSpeed*=-1
