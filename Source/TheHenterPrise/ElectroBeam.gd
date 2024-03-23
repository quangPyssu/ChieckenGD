extends bullet

var ani:Node2D
var chargeTime:float = 2

var preParticle: PackedScene = preload("res://Asset/particle/CustomParticle_ChargeElectron.tscn")

func _ready():
	HP = 99999999
	ani = $AnimationCenter
	$BulletSound.play()
	Global.isShaking=true
	Global.isShaking=false
	Global.shakeStrength=3
	ani.visible=false
	set_process(false)
	position=Vector2(-72.0,-161.0)
	charge(30)

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
	tween.tween_property($Charging/Charge, "energy", 30,chargeTime).set_trans(Tween.TRANS_LINEAR)
	
	for i in cnt:
		for j in 3:
			var parti:Sprite2D = preParticle.instantiate()
			var rot:Vector2 = Vector2(1,0).rotated(randf_range(0.0,PI*2))
			parti.global_position = global_position+rot*300.0+Vector2(30.0,200.0)
			parti.rotation=rot.angle()+PI
			var teen:Tween = get_tree().create_tween()
			teen.tween_property(parti, "position", global_position+Vector2(30.0,200.0),0.5).set_trans(Tween.TRANS_LINEAR)
			
			get_node("/root/Game/Projectiles").add_child(parti)
		await get_tree().create_timer(chargeTime/(cnt-1)).timeout 
	
	ani.visible=true
	set_process(true)
	await get_tree().create_timer(chargeTime).timeout 
	queue_free()

func _on_tree_exited():
	Global.isShaking=false
