extends Node2D

@export var HP:float = 100.0
var MaxHP:float 
@export var isInvincible=false
var isGoing: bool = false
var isDead: bool = false

var velocity:Vector2 
var spinDeg:float

func _ready():
	MaxHP=HP
	set_physics_process(false)

func _physics_process(delta):
	rotation_degrees+=delta*spinDeg
	global_position+=velocity*delta

func take_damage(damage:float):
	if isInvincible:
		return
	#at three quarter health
	var damed: float = HP - damage
	HP = damed

	if HP<=0 and !isDead:
		kill()

func kill():
	isDead = true
	call_deferred("detach")
	
	await get_tree().create_timer(4.5).timeout
	queue_free()
	
func detach():
	reparent(get_node("/root/Game/Projectiles"))
	$Audio.play()
	velocity=Vector2(0.0,randfn(-100,50)).rotated(randf_range(-PI/4.0,PI/4.0))
	spinDeg=randi_range(-30,30)
	
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self, "scale",Vector2.ZERO,4.0).set_trans(Tween.TRANS_EXPO)
		
	set_physics_process(true)
	
