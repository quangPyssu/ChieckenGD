extends entity

var nearPlayer:bool = false
var player:Node2D 
var preEgg:PackedScene = preload("res://Egg.tscn")

func _ready():
    super._ready()
    HP = 5
    player = get_node("/root/Game/Player")
    speed=10000
    direction = Vector2(5,-3).normalized()
    inClampedScreen = true

    #goto middle of the screen
    gotoPosition(Global.ScreenSize/2, speed)
    print (Global.ScreenSize/2)

func _process(_delta):
    super._process(_delta)
    
    if nearPlayer:
        $AnimationCenter/ChickenBody._look_at_player(player.global_position)
    else:
        $AnimationCenter/ChickenBody._reset_look()

    if Input.is_action_just_pressed("TestButton-"):
        gotoPosition(player.global_position, speed)

func _on_area_2d_body_entered(_body:Node2D):
    nearPlayer = true

func _on_area_2d_body_exited(_body:Node2D):
    nearPlayer = false

func take_damage(damage:int):
    super.take_damage(damage)

func _on_attack_timer_timeout():
    var Egg=preEgg.instantiate()
    Egg.global_position = global_position
    get_parent().add_child(Egg)