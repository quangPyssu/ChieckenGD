extends entity

var Ani:AnimationPlayer 

var preEss:PackedScene = preload("res://Egg.tscn")
var preEgg:PackedScene = preload("res://lighting.tscn")
var preBaked:PackedScene = preload("res://the_Sky_Descend.tscn")

const visionBox:Vector2 = Vector2i(600.0,600.0)
const eyeBox:Vector2 = Vector2i(90.0,90.0)
var eyePos:Vector2 = Vector2i(0.0,0.0)
var eyeSpeed:float = 40
var rotationSpeed:float = 0
var eyeRoationSpeed:float = PI/4.0

var attackRange:int = 0

var lockedMode:bool=false
func _ready():
	super._ready()
	Ani=$AnimationCenter/Animation
	$AttackTimer.wait_time=8
	$AttackTimer.start()
	lockedMode=true

func the_Sky_Descend():
	Ani.play("Henporer_The_Sky_Descend")
	Ani.queue("Henporer_flap")
	
	await get_tree().create_timer(0.65).timeout
		
	var egg:bullet=preBaked.instantiate()
	get_node("/root/Game/Projectiles").add_child(egg)
	egg.position=Global.PlayerPos
	
func ForceLighting():
	Ani.play("Henporer_Lighting")
	Ani.queue("Henporer_flap")
		
	var egg:bullet =preEgg.instantiate()
	$"AnimationCenter/Henperor-cape".add_child(egg)
	egg.look_at(Global.PlayerPos)
	egg.rotation-=PI/4.0
	
	await get_tree().create_timer(7.5).timeout 
	Ani.play("Henporer_Lighting")
	Ani.queue("Henporer_flap")
	
	var egs:bullet =preEgg.instantiate()
	egs.rotSpeed=-0.7
	$"AnimationCenter/Henperor-cape".add_child(egs)
	egs.look_at(Global.PlayerPos)
	egs.rotation+=PI/4.0

func QuarterLighting():
	Ani.play("Henporer_Lighting")
	Ani.queue("Henporer_flap")
	
	for i in 4:
		var egg:bullet =preEgg.instantiate()
		$"AnimationCenter/Henperor-cape".add_child(egg)
		egg.look_at(Global.PlayerPos)
		egg.rotation-=PI/4.0+PI*i/2.0
		egg.get_child(egg.get_child_count()-1).volume_db-=15
		
func SpinEgg():
	for i in 4:
		var egg:bullet =preEss.instantiate()
		$EggSingularity/Anchor.add_child(egg)
		egg.look_at(Global.PlayerPos)
		egg.rotation-=PI/4.0+PI*i/2.0
		egg.direction=Vector2(0,1).rotated(egg.rotation)
		egg.accelaration=-50
		egg.damage=3
	
func _process(delta):
	if Input.is_action_just_pressed("TestButton+"):
		the_Sky_Descend()
		
	if Input.is_action_just_pressed("TestButton-"):
		ForceLighting()
		
	if lockedMode:
		$EggSingularity/Anchor.rotation+=delta*0.5
		#print($EggSingularity/Anchor.get_child_count())
	
func atThreeQuarterHealth():
	attackRange=1
	call_deferred("QuarterLighting")
	$AttackTimer.wait_time=15
	#$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	#$Audio.play()
	
func atHalfHealth():
	attackRange=2
	call_deferred("the_Sky_Descend")
	$AttackTimer.start()
	#$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	#$Audio.play()

func atQuarterHealth():
	#$Audio.stream=preload("res://Asset/Sounds/(chickbossCry).ogg")
	#$Audio.play()
	call_deferred("the_Sky_Descend")
	await get_tree().create_timer(3).timeout
	call_deferred("the_Sky_Descend")
	await get_tree().create_timer(3).timeout
	call_deferred("the_Sky_Descend")
	await get_tree().create_timer(3).timeout
	attackRange=3

func kill():
	if !isDead:
		isDead = true

		stopProcess()

		await get_tree().create_timer(2).timeout
		queue_free()


func attack():
	match attackRange:
		0:
			QuarterLighting()
		1:
			ForceLighting()
		2:
			ForceLighting()
			the_Sky_Descend()
		3:
			ForceLighting()
			the_Sky_Descend()
			await get_tree().create_timer(7).timeout
			the_Sky_Descend()

func _on_attack_timer_timeout():
	attack()


func _on_attack_timer_2_timeout():
	if lockedMode:
		SpinEgg()
