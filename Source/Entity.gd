extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for AnimationPiece in %AnimationCenter.get_children():
		if AnimationPiece.has_method("play"):
			AnimationPiece.play("Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
