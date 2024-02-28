extends entity

var nearPlayer:bool = false

var preEgg:PackedScene = preload("res://Egg.tscn")
var feather:PackedScene = preload("res://Asset/particle/Particle_Feather.tscn")

func _ready():  
	direction = Vector2(5,-3).normalized()
	inClampedScreen = true
	$AttackTimer.wait_time=randi()%5+3
	$AttackTimer.start()
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	if get_parent():
		#keep Chicken upright
		rotation_degrees = -get_parent().rotation_degrees

func _process(_delta):    
	if nearPlayer:
		$AnimationCenter/ChickenBody._look_at_player(Global.PlayerPos)
	else:
		$AnimationCenter/ChickenBody._reset_look()	

func _on_area_2d_body_entered(_body:Node2D):
	nearPlayer = true

func _on_area_2d_body_exited(_body:Node2D):
	nearPlayer = false

func take_damage(damage:int):
	super.take_damage(damage)

func _on_attack_timer_timeout():
	if !isDead:
		var Egg=preEgg.instantiate()
		get_node("/root/Game/Projectiles").add_child(Egg)
		Egg.global_position = global_position

func kill():
	if !isDead:
		var f = feather.instantiate()
		f.global_position = global_position
		get_node("/root/Game/Projectiles").add_child(f)
		super.kill()

	return 1
