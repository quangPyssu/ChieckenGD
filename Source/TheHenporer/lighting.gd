extends bullet

var rotSpeed:float=0.7

func _ready():
	HP = 99999999
	
	%AnimationCenter.visible=false
	set_process(false)

func charge():
	set_process(true)
	$BulletSound.play()	
	$Warningstrip5.visible=false
	%AnimationCenter.visible=true
	await get_tree().create_timer(6.5).timeout
	queue_free()

func _process(delta):
	super._process(delta)
	var target: Array[Area2D] = get_overlapping_areas()
	
	for i in target:
		print(i.get_parent())
		if i is bullet:
			return
		else:
			i.get_parent().take_damage(damage)
			
func _physics_process(delta):
	rotation+=delta*rotSpeed
 
func _on_area_entered(_area:Area2D):
	pass
