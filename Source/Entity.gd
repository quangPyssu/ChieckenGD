extends CharacterBody2D
class_name entity

@export var HP:int = 100
@export var timerStart:float = 0
@export var timerEnd:float = -1.0

var direction: Vector2 = Vector2(0, 0)
var speed: float = 0
@export var inClampedScreen: bool = true

var StartClock:Timer = null
var EndClock:Timer = null

func _ready():
	setTimer()

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

func _on_entity_timeout():
	print("entity timeout")
	queue_free()

func _on_entity_timein():
	print("entity timein")
	
	if StartClock!=null:
		StartClock.queue_free()

	if EndClock!=null:
		EndClock.start()

func setTimer():
	if timerEnd!=-1.0:
		EndClock = Timer.new()
		EndClock.set_wait_time(timerEnd)
		EndClock.set_one_shot(true)
		EndClock.timeout.connect(_on_entity_timeout)
		add_child(EndClock)

	if timerStart>0.0:
		StartClock = Timer.new()
		StartClock.set_wait_time(timerStart)
		StartClock.set_one_shot(true)
		StartClock.timeout.connect(_on_entity_timein)
		add_child(StartClock)
		StartClock.start()
	else:
		_on_entity_timein()