extends bullet

var ani:Node2D
var chargeTime:float = 2
var blastScale:float = 1

func _ready():
	HP = 99999999
	ani = %AnimationCenter
	#$Warningstrip4/AnimationPlayer.play("default")
	
	ani.visible=false
	set_process(false)

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

func charge():
	$Warningstrip5.visible=false
	ani.visible=true
	set_process(true)
	$BulletSound.play()
	await get_tree().create_timer(chargeTime*blastScale).timeout 
	queue_free()
