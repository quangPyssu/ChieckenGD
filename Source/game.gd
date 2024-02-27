extends Node2D

@onready var BG_pos=-%BlueBlankBackground.texture.get_size().y/2*%BlueBlankBackground.scale.y
var WaveCount=0
var CurrentWave=0

# Called when the node enters the scene tree for the first time.
func _ready():
	#set the window size
	get_viewport().size=Global.ScreenSize
	print("Window Size: ",get_viewport().size)

	$Player.position=get_viewport().size/2
	
	#hide the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	%BlueBlankBackground.position=Vector2(0,BG_pos)

	for wave:Node2D in $Enemies.get_children():
		wave.set_process_mode(PROCESS_MODE_DISABLED)
		wave.visible=0
	
	$Enemies.get_child(0).set_process_mode(0)
	$Enemies.get_child(0).visible=1

func _process(delta):
	if Input.is_action_just_pressed("ForceQuit"):
		get_tree().quit()
		
	%BlueBlankBackground.position.y=%BlueBlankBackground.position.y+100.0*delta
		
	if %BlueBlankBackground.position.y>=0:
		%BlueBlankBackground.position.y=BG_pos

	if Global.defeated:
		pass
		#get_tree().change_scene("res://scenes/scene_gameover.tscn")

	if !$Enemies.get_children().is_empty():
		if $Enemies.get_child(0).get_children().is_empty():
			$Enemies.get_child(0).queue_free()
			CurrentWave+=1
			print("Wave ",CurrentWave," has been defeated")
			
			if $Enemies.get_children().size()>1:
				$Enemies.get_child(1).set_process_mode(0)
				$Enemies.get_child(1).visible=1

func _on_player_attack(_WeaponType:int):
	var Bullet = preload("res://bullet_player_normal.tscn").instantiate()
	Bullet.global_position = $Player.global_position + Vector2(0, -50)
	%Projectiles.add_child(Bullet)
