extends Node2D

@onready var BG_pos=-%BlueBlankBackground.texture.get_size().y/2*%BlueBlankBackground.scale.y
var AfterGame:PackedScene = preload("res://UI/LevelEndMenu.tscn")
var CurrentWave:int=0
var FinalWave:bool=false

var packedAttack: Array[PackedScene]

var BossMusic: Array[String]=["res://Asset/Sounds/Music/BeOfGoodCheer.ogg","res://Asset/Sounds/Music/magicJinzoStraw.ogg",
"res://Asset/Sounds/Music/LoveMasterSpark.ogg","res://Asset/Sounds/Music/HelianAlien.ogg",
"res://Asset/Sounds/Music/Necrofantasia.ogg","res://Asset/Sounds/Music/PureFurries.ogg"]

var Levels: Array [String] = ["res://level0.tscn","res://level1.tscn","res://level2.tscn","res://level3.tscn","res://level4.tscn","res://level5.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	#set the window sizes
	Global.defeated = false
	Global.LevelEnd = false
	Global.HP = Global.maxHP
	Global.shakeStrength=0
	$Player.position=Global.ScreenSize/2
	#print(DisplayServer.window_get_size())	
	
	#hide the moused
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	%BlueBlankBackground.position.y=BG_pos

	for wave:Node2D in $Enemies.get_children():
		wave.set_process_mode(PROCESS_MODE_DISABLED)
		wave.visible=0
	
	$Enemies.get_child(0).set_process_mode(PROCESS_MODE_INHERIT)
	$Enemies.get_child(0).visible=1
	
	loadAttack()

func _process(delta):
	%FPS.set_text("FPS %d" % Engine.get_frames_per_second())
	
	if Input.is_action_just_pressed("FramShow"):
		%FPS.visible=!%FPS.visible
	
	if Input.is_action_just_pressed("ForceQuit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("PauseToggle"):
		$Paused.PauseGame()
		
	if Input.is_action_just_pressed("ChangeWeapon"):
		Global.CurrentWeapon=(Global.CurrentWeapon+1)%2
		$Player.changeWeapon()
	
	cameraShake()
	if !FinalWave:
		%BlueBlankBackground.position.y=%BlueBlankBackground.position.y+70.0*delta
		
	if %BlueBlankBackground.position.y>=0:
		%BlueBlankBackground.position.y=BG_pos

	if Global.LevelEnd:
		await get_tree().create_timer(2.0).timeout
		$Paused.PauseGame()
		$Paused.queue_free()
		set_process(false)
		add_child(AfterGame.instantiate())
		return

	if !$Enemies.get_children().is_empty():
		if $Enemies.get_child(0).get_children().is_empty():
			$Enemies.get_child(0).queue_free()
			CurrentWave+=1
			print("Wave ",CurrentWave," has been defeated")
			
			if $Enemies.get_children().size()>1:
				$Enemies.get_child(1).set_process_mode(PROCESS_MODE_INHERIT)
				$Enemies.get_child(1).visible=1
			
			if $Enemies.get_children().size()==2:
				$Music.set_stream(load(BossMusic[Global.CurrentLevel]))
				$Music.play()
				FinalWave=true
	else: 
		#await get_tree().create_timer(3.0)
		Global.LevelEnd=1

func _on_player_attack():
	var Bullet = packedAttack[Global.CurrentWeapon].instantiate()
	
	match Global.EquippedWeapon[Global.CurrentWeapon]:
		0,2,3:
			Bullet.global_position = $Player.global_position + Vector2(0, -50)
			%Projectiles.add_child(Bullet)
		1:
			$Player.add_child(Bullet)
			
func loadAttack():
	for i in 2:
		var a:PackedScene 
		match Global.EquippedWeapon[i]:
			0:
				a=preload("res://bullet_player_normal.tscn")
			1: 
				a=preload("res://SmallBeam_Player.tscn")
			2:
				a=preload("res://miniBullet_Player.tscn")
			
				
		packedAttack.append(a)

func cameraShake():
	if Global.shakeStrength:
		$Camera.offset=Vector2(randi_range(-Global.shakeStrength,Global.shakeStrength),randi_range(-Global.shakeStrength,Global.shakeStrength))
	else:
		$Camera.offset=Vector2.ZERO
