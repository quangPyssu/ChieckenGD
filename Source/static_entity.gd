extends RigidBody2D

class_name static_entity

var direction: Vector2 = Vector2(0, 0)
var speed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for AnimationPiece in %AnimationCenter.get_children():
		if AnimationPiece.has_method("play"):
			AnimationPiece.play("Default")
	print("static entity ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

