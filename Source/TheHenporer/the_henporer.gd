extends entity

var Ani:AnimationPlayer 
func _ready():
	Ani=$AnimationCenter/Animation

func the_Sky_Descend():
	print("boom")
	
func _process(delta):
	if Input.is_action_just_pressed("TestButton+"):
		Ani.play("Henporer_The_Sky_Descend")
		Ani.queue("Henporer_flap")
