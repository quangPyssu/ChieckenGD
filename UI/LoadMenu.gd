extends Control

var Levels: Array [String] = ["res://level0.tscn","res://level1.tscn","res://level2.tscn","res://level3.tscn","res://level4.tscn"]

var Data = preload("res://UI/Data.gd").new()
var loading:bool = false
var loaded:float = 0

var progress = []

var pos:Array [Vector2] = [Vector2(1215,1060),Vector2(1215,938)]

func _ready():
	$StartBtn.set_disabled(true)
	
	for i in get_children():
		if i is Sprite2D:
			var a:Button=i.get_child(0)
			a.pressed.connect(_press_butt.bind(a.get_meta("Level"),a.get_meta("Ani")))
	
	for i in Global.UnlockedLevel:
		$Link.get_child(i).visible=true
	
	for i in 4:
		$WeaponSelect/Weapon.get_child(i).disabled=not Global.UnlockedWeapon[i]
		$WeaponSelect/Weapon.get_child(i).pressed.connect(_changeWepon.bind(i))
		
		$WeaponSelect/Weapon5.get_child(i).disabled=not Global.UnlockedWeapon[i]
		$WeaponSelect/Weapon5.get_child(i).pressed.connect(_changeSideWepon.bind(i))
		
		$WeaponSelect/Special.get_child(i).disabled=not Global.UnlockedSpecial[i]
		$WeaponSelect/Special.get_child(i).pressed.connect(_changeSpecial.bind(i))
		
	%WeaponSelect.global_position=$WeaponSelect/Weapon.get_child(Global.EquippedWeapon[0]).global_position+Vector2(20.0,16.0)
	%WeaponSelect2.global_position=$WeaponSelect/Weapon.get_child(Global.EquippedWeapon[1]).global_position+Vector2(20.0,16.0)
	%SpecialSelect.global_position=$WeaponSelect/Special.get_child(Global.SpecialType).global_position+Vector2(20.0,16.0)
	
	
		
func _changeWepon(i:int):
	Global.EquippedWeapon[0]=i
	%WeaponSelect.global_position=$WeaponSelect/Weapon.get_child(i).global_position
	
func _changeSideWepon(i:int):
	Global.EquippedWeapon[1]=i
	%WeaponSelect2.global_position=$WeaponSelect/Weapon.get_child(i).global_position
	
func _changeSpecial(i:int):
	Global.SpecialType=i
	%SpecialSelect.global_position=$WeaponSelect/Special.get_child(i).global_position

func _press_butt(i:int,ani:String):
	print (i , " " ,Global.UnlockedLevel)
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


