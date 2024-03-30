extends entity

func _ready():
	scale=Vector2(1.0,1.0)
	super._ready()

var preEgg:PackedScene = preload("res://miniBullet_enemy.tscn")

var attackRange:int = 1
var ramCnt:int = 0

var lockedMode:bool=false

var damage:float = 40

func _process(delta):
	$AnimationCenter/Exhaust.scale.x=randf_range(0.9,1.2)	
	if (ramCnt):
		$AnimationCenter/Exhaust.scale.x+=1
		if (!lockedMode):
			ram()
		else:
			if global_position.x <= -500 or global_position.x >= Global.ScreenSize.x+500 or global_position.y <= -500 or global_position.y >= Global.ScreenSize.y+500:
				
				isGoing=false
				lockedMode=false
				ramCnt-=1
				direction=Vector2.ZERO
				
				if !ramCnt:
					%Border.progress_ratio = randf_range(0.04,0.26)
					$AttackTimer.start()
					$Audio.stop()
				else:
					%Border.progress_ratio = randf()
				global_position=%Border.position
				
	else:
		_look_at_player(delta)
		
	
	
func atThreeQuarterHealth():
	attackRange=2
	call_deferred("SpecialA")
	ramCnt=6
	$AttackTimer.wait_time=1.2
	
func atHalfHealth():
	attackRange=3
	call_deferred("SpecialA")
	ramCnt=8
	$AttackTimer.wait_time=1

func atQuarterHealth():
	call_deferred("SpecialA")
	ramCnt=10
	$AttackTimer.wait_time=0.7

func SpecialA():
	$Audio.stream=preload("res://Asset/Sounds/engineChef.ogg")
	$Audio.play()
	$Explosion.play()
	lockedMode=false
	$AnimationCenter/Exhaust.position.y=0
	$AttackTimer.stop()
	
func ram():
	lockedMode=true
	var desti:Vector2 = global_position+(Global.PlayerPos-global_position)*100
	gotoPosition(desti,65000.0)
	look_at(Global.PlayerPos)
	%SpaceShipBody.frame=16

func kill():
	if !isDead:
		isDead = true
		
		$AnimationCenter.visible=false
		stopProcess()
	
		$Explosion.play()
		$Audio.stream=preload("res://Asset/Sounds/PlayerExplode.ogg")
		$Audio.play()

		await get_tree().create_timer(2).timeout
		queue_free()

func attack():
	var Egg=preEgg.instantiate()
	get_node("/root/Game/Projectiles").add_child(Egg)
	var rot:float = randf_range(-1,1)*PI/36+rotation-PI/2
	Egg.rotation=PI/2+rot
	Egg.direction=Vector2(0,1).rotated(rot)
	Egg.global_position = $Marker.global_position

func _on_attack_timer_timeout():
	attack()
	
func _look_at_player(delta):
	var xDiff:int = global_position.x-Global.PlayerPos.x
	
	rotation=PI/2
	
	var fram:int=clampi(xDiff/30+16,0,32)
	
	%SpaceShipBody.frame=fram
	
	xDiff=absi(xDiff)
	xDiff=xDiff*xDiff
	xDiff=mini(xDiff,27000)
	gotoPosition(Vector2(Global.PlayerPos.x,200),xDiff)
	
	$AnimationCenter/Exhaust.position.y=-fram+15
	$AnimationCenter/Exhaust.position.x=abs(fram-16)/2-149

func _on_hit_box_area_entered(area):
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
	elif "HP" in area:
		if area.HP>0:
			area.HP-=damage	
