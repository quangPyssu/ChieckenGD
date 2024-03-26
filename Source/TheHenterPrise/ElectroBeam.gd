extends bullet

var ani:Node2D
var chargeTime:float = 2
var blastScale:float = 1

var preParticle: PackedScene = preload("res://Asset/particle/CustomParticle_ChargeElectron.tscn")

func _ready():
	HP = 99999999
	ani = $AnimationCenter
	$BulletSound.play()
	
	Global.shakeStrength+=5
	ani.visible=false
	set_process(false)
	position=Vector2(-72.0,-161.0)
	charge(30)
	await get_tree().create_timer(chargeTime+0.15).timeout 
	$BeamSound.play()

func _process(delta):
	super._process(delta)
	var target: Array[Area2D] = get_overlapping_areas()
	
	for i in target:
		if i is bullet:
			i.kill()
		else:
			i.get_parent().take_damage(damage)
 
func _on_area_entered(_area:Area2D):
	pass

func charge(cnt:int):
	var tween:Tween = get_tree().create_tween()
	tween.tween_property($Charging/Charge, "energy", 30,chargeTime).set_trans(Tween.TRANS_BOUNCE)
	
	var taeen:Tween = get_tree().create_tween()
	taeen.tween_property($Flarebig, "scale", Vector2(3.5,3.5),chargeTime).set_trans(Tween.TRANS_BOUNCE)
	
	for i in cnt:
		for j in 3:
			var parti:Sprite2D = preParticle.instantiate()
			var rot:Vector2 = Vector2(1,0).rotated(randf_range(0.0,PI*2))
			parti.position = rot*300.0
			parti.rotation=rot.angle()+PI
			var teen:Tween = get_tree().create_tween()
			teen.tween_property(parti, "position", Vector2.ZERO,0.5).set_trans(Tween.TRANS_LINEAR)
			
			$Marker2D.add_child(parti)
			#get_node("/root/Game/Projectiles").add_child(parti)
		await get_tree().create_timer(chargeTime/(cnt-1)).timeout 
	
	ani.visible=true
	set_process(true)
	
	var tseen:Tween = get_tree().create_tween()
	tseen.tween_property($Flarebig, "scale", Vector2(2.0,2.0),chargeTime*blastScale).set_trans(Tween.TRANS_BOUNCE)

	await get_tree().create_timer(chargeTime*blastScale).timeout 
	Global.shakeStrength-=5
	queue_free()
