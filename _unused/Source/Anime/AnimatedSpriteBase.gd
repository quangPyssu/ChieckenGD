extends AnimatedSprite2D

@export var IsAutoPlay: bool = true

func _ready():
    #check is has default animation
    if IsAutoPlay:
        autoplay="default"
    