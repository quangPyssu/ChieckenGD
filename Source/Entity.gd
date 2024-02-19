extends CharacterBody2D
class_name entity

@export var HP:int = 100
@export var timerStart:float = 0
@export var timerEnd:float = 0

var direction: Vector2 = Vector2(0, 0)
var speed: float = 0
@export var inClampedScreen: bool = true

func _ready():
	for AnimationPiece in %AnimationCenter.get_children():
			animation_cascade(AnimationPiece)
	print("entity ready")

func _physics_process(_delta):
	move_and_slide()
	if inClampedScreen: #clamp in the screen		
		position.x = clamp(position.x, 0, get_viewport().size.x)
		position.y = clamp(position.y, 0, get_viewport().size.y)

func _process(_delta):
	pass

func animation_cascade(AnimationPiece: Node):
	if AnimationPiece.has_method("play"):
		AnimationPiece.play("default")
	else:
		for AnimationPiecePiece in AnimationPiece.get_children():
			animation_cascade(AnimationPiecePiece)