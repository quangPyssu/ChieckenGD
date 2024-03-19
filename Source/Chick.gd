extends entity

var preEgg:PackedScene = preload("res://BlueZig.tscn")

func _ready():  
	direction = Vector2(5,-3).normalized()
	inClampedScreen = true
	super._ready()

func kill():
	if !isDead:
		isDead=true
		$AnimationCenter/AnimationPlayer.play("Implode")
		await get_tree().create_timer(0.5).timeout
		call_deferred("attack")

func attack():
	var egg = preEgg.instantiate()
	egg.global_position = global_position
	get_node("/root/Game/Projectiles").add_child(egg)
	queue_free()
