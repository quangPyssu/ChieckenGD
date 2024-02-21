extends Node2D

@onready var BG_pos=%BlueBlankBackground.position.y


# Called when the node enters the scene tree for the first time.
func _ready():
	#set the window size
	get_viewport().size=Vector2(1920,1080)

	$Player.position=get_viewport().size/2
	
	#hide the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _process(delta):
	if Input.is_action_just_pressed("ForceQuit"):
		get_tree().quit()
		
	%BlueBlankBackground.position.y=%BlueBlankBackground.position.y+300.0*delta
		
	if %BlueBlankBackground.position.y>0:
		%BlueBlankBackground.position.y=BG_pos

	#print("Player Position: ",$Player.global_position)


func _on_player_attack(_WeaponType:int):
	var Bullet = preload("res://bullet_player_normal.tscn").instantiate()
	Bullet.position = $Player.global_position
	%Projectiles.add_child(Bullet)
