extends Area2D

class_name bullet

var BaseSpeed: float = 300.0
var velocity: Vector2 = Vector2.ZERO
var accelaration: float = 0.0
var direction: Vector2 = Vector2(0,-1)
var damage: int = 1
@export var BounceCount: int = 0

@export var inClampedScreen: bool = true

func _ready():
	for AnimationPiece in %AnimationCenter.get_children():
			animation_cascade(AnimationPiece)
	print("Bullet ready")

func _process(delta):
	BaseSpeed += accelaration * delta
	velocity = direction * BaseSpeed
	position += velocity * delta

	if inClampedScreen: #clamp in the screen		
		position.x = clamp(position.x, 0, get_viewport().size.x)
		position.y = clamp(position.y, 0, get_viewport().size.y)
	else: #destroy when out of screen
		if position.x < -300 or position.x > get_viewport().size.x+300 or position.y < -300 or position.y > get_viewport().size.y+300:
			queue_free()


func animation_cascade(AnimationPiece: Node):
	if AnimationPiece.has_method("play"):
		AnimationPiece.play("default")
	else:
		for AnimationPiecePiece in AnimationPiece.get_children():
			animation_cascade(AnimationPiecePiece)
