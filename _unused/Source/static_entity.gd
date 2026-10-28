extends RigidBody2D

class_name static_entity

var direction: Vector2 = Vector2(0, 0)
var speed: float = 0
@export var HP:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func take_damage(damage:int=1):
	HP -= damage
	if HP <= 0:
		kill()

func kill():
	print("kill ",self)
	queue_free()
