extends Control

var Levels: Array [String] = ["res://level0.tscn","res://level1.tscn","res://Level2.tscn","res://Level3.tscn","res://Level4.tscn","res://Level5.tscn"]

var Data = preload("res://UI/Data.gd").new()
var loading:bool = false
var loaded:float = 0

var progress = []

var pos:Array [Vector2] = [Vector2(1170,1060),Vector2(1170,938)]
var pos2:Array [Vector2] = [Vector2(314,1060),Vector2(314,938)]

func _ready():
	$StartBtn.set_disabled(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	for i in get_children():
		if i is Sprite2D:
			var a:Button=i.get_child(0)
			a.pressed.connect(_press_butt.bind(a.get_meta("Level"),a.get_meta("Ani")))
	
	for i in Global.UnlockedLevel:
		$Link.get_child(i).visible=true
	
	for i in 3:
		$WeaponSelect/Weapon.get_child(i).disabled=not Global.UnlockedWeapon[i]
		$WeaponSelect/Weapon.get_child(i).pressed.connect(_changeWepon.bind(i))
		
		$WeaponSelect/Weapon5.get_child(i).disabled=not Global.UnlockedWeapon[i]
		$WeaponSelect/Weapon5.get_child(i).pressed.connect(_changeSideWepon.bind(i))
		
		$WeaponSelect/Special.get_child(i).disabled=not Global.UnlockedSpecial[i]
		$WeaponSelect/Special.get_child(i).pressed.connect(_changeSpecial.bind(i))
		
	await get_tree().create_timer(0.5).timeout
	_changeWepon(Global.EquippedWeapon[0])
	_changeSideWepon(Global.EquippedWeapon[1])
	_changeSpecial(Global.SpecialType)
	
func _changeWepon(i:int):
	Global.EquippedWeapon[0]=i
	%WeaponSelect.global_position=$WeaponSelect/Weapon.get_child(i).global_position
	
func _changeSideWepon(i:int):
	Global.EquippedWeapon[1]=i
	%WeaponSelect2.global_position=$WeaponSelect/Weapon.get_child(i).global_position
	
func _changeSpecial(i:int):
	if i>2:
		return
	Global.SpecialType=i
	%SpecialSelect.global_position=$WeaponSelect/Special.get_child(i).global_position

func _press_butt(i:int,ani:String):

	if Global.UnlockedLevel>=i:
		Global.CurrentLevel=i
		
		for j in get_children():
			if j is Sprite2D:
				j.frame=0
		
		$AnimationPlayer.play(ani)
		$StartBtn.set_disabled(false)
	
	else:
		$AnimationPlayer.stop()
		$StartBtn.set_disabled(true)

func _process(_delta):
	if loading:
		loaded = ResourceLoader.load_threaded_get_status(Levels[Global.CurrentLevel],progress)
		
		$ProgressBar.value=progress[0]*100
		
		if loaded == ResourceLoader.THREAD_LOAD_LOADED:
			await get_tree().create_timer(0.2).timeout
			var newScene = ResourceLoader.load_threaded_get(Levels[Global.CurrentLevel])
			get_tree().change_scene_to_packed(newScene)
			
	if Input.is_action_just_pressed("Shift"):
		$WeaponSelect/Weapon.visible=false
		
	if Input.is_action_just_released("Shift"):
		$WeaponSelect/Weapon.visible=true
		
	if Input.is_action_just_pressed("PauseToggle"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_start_btn_pressed():
	Data.save_Data()
	$ProgressBar.visible=true
	await get_tree().create_timer(0.5).timeout
	
	ResourceLoader.load_threaded_request(Levels[Global.CurrentLevel])
	loading=true


func _on_weapon_select_mouse_entered():
	var tween:Tween = get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property($WeaponSelect,"position" ,pos[1],0.5 ).set_trans(Tween.TRANS_LINEAR)


func _on_weapon_select_mouse_exited():
	var tween:Tween = get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property($WeaponSelect,"position" ,pos[0],0.5 ).set_trans(Tween.TRANS_LINEAR)




func _on_how_to_play_mouse_entered():
	var tween:Tween = get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property($HowToPlay,"position" ,pos2[1],0.5 ).set_trans(Tween.TRANS_LINEAR)


func _on_how_to_play_mouse_exited():
	var tween:Tween = get_tree().create_tween()
	tween.set_parallel(true)

	tween.tween_property($HowToPlay,"position" ,pos2[0],0.5 ).set_trans(Tween.TRANS_LINEAR)
