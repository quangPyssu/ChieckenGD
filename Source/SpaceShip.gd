extends entity

func _ready():
	scale=Vector2(1.0,1.0)
	super._ready()

var preEss:PackedScene = preload("res://UFOBullet.tscn")
var preEgg:PackedScene = preload("res://BlueZig.tscn")

var attackRange:int = 1

var lockedMode:bool=false

func _process(delta):
	if Input.is_action_just_pressed("TestButton+"):
		kill()
	
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

	$AttackTimer2.start()
	
func kill():
	if !isDead:
		isDead = true

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
	

func attack():
	pass

func _on_attack_timer_timeout():
	attack()
	
func flicker():
	if canFlicker and !isFlickering:
		isFlickering = true
		$AnimationCenter/AnimationPlayer.play("EggHurt")
		await get_tree().create_timer(0.1).timeout
		isFlickering = false		
	
func _look_at_player(delta):
	pass
