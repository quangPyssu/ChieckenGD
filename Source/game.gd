extends Node2D

@onready var BG_pos=%BlueBlankBackground.position.y


# Called when the node enters the scene tree for the first time.
func _ready():
	#set the window size
	get_viewport().size=Global.ScreenSize
	print("Window Size: ",get_viewport().size)

	$Player.position=get_viewport().size/2
	
	#hide the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _process(delta):
	if Input.is_action_just_pressed("ForceQuit"):
		get_tree().quit()
		
	%BlueBlankBackground.position.y=%BlueBlankBackground.position.y+100.0*delta
		
	if %BlueBlankBackground.position.y>0:
		%BlueBlankBackground.position.y=BG_pos

	if Global.defeated:
		pass
		#get_tree().change_scene("res://scenes/scene_gameover.tscn")

	#print("Player Position: ",$Player.global_position)


func _on_player_attack(_WeaponType:int):
	var Bullet = preload("res://bullet_player_normal.tscn").instantiate()
	Bullet.global_position = $Player.global_position + Vector2(0, -50)
	%Projectiles.add_child(Bullet)
