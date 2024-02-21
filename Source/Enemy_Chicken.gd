extends entity

var nearPlayer:bool = false
var player:Node2D 

func _ready():
    super._ready()
    player = get_node("/root/Game/Player")

func _process(_delta):
    super._process(_delta)
    if nearPlayer:
        $AnimationCenter/ChickenBody._look_at_player(player.global_position)
    else:
        pass

func _on_area_2d_body_entered(body:Node2D):
    nearPlayer = true

func _on_area_2d_body_exited(body:Node2D):
    nearPlayer = false