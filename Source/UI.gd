extends CanvasLayer

var Weapon:Array [TextureRect] 
var CurWeapon:int = 0

func _ready():
	%HealthBar.value = Global.HP
	%HealthBar.max_value = Global.maxHP
	%DamageBar.value = Global.HP
	%DamageBar.max_value = Global.maxHP

	%SpecialBar.value = Global.SP
	%SpecialBar.max_value = Global.maxSP
	
	%SpecialRecharge.value = Global.SP
	%SpecialRecharge.max_value = Global.maxSP
	%SpecialRecharge.step = 0.1
	
	var cnt:int =0
	for i in %Weapons.get_children():
		Weapon.append(i)
		i.get_node("WeaponRecharge").max_value = Global.WeaponTime[Global.EquippedWeapon[cnt]]
		i.get_node("WeaponRecharge").value = Global.WeaponTime[Global.EquippedWeapon[cnt]]
		i.get_node("WeaponRecharge").step=0.05
		
		var s:String="res://Asset/Icon/WeaponIcon"+str(Global.EquippedWeapon[cnt])+".jpg"
		i.texture=load(s)
		i.get_node("WeaponRecharge").texture_progress=load(s)
		
		cnt+=1
		
	var s:String ="res://Asset/Icon/SpecialIcon0.jpg"
	match Global.SpecialType:
		1:
			s="res://Asset/Icon/SpecialIcon2.jpg"
		2:
			s="res://Asset/Icon/SpecialIcon4.jpg"
		3:
			s="res://Asset/Icon/SpecialIcon1.jpg"
	
	$Control/AttackBG/HBoxContainer/SpecialSprite.texture=load(s)
	%SpecialRecharge.texture_progress=load(s)
	
		
	CurWeapon=1
	changeWeapon()

func _process(_delta):
	#health bar is progressbar
	healthBarUpdate()
	#special bar is progressbar
	%SpecialBar.value = Global.SP
	%SpecialRecharge.value = Global.SP

	if CurWeapon!=Global.CurrentWeapon:
		changeWeapon()

	Weapon[CurWeapon].get_node("WeaponRecharge").value = Global.AP
	
	if Global.SP==Global.maxSP:
		%SpecialSelect.visible=1
	else: 
		%SpecialSelect.visible=0
		
func changeWeapon():
	Weapon[CurWeapon].get_child(0).value=0
	Weapon[CurWeapon].get_child(1).visible=0
	
	CurWeapon=Global.CurrentWeapon
	
	Weapon[CurWeapon].get_child(0).value=0
	Weapon[CurWeapon].get_child(1).visible=1

func healthBarUpdate():
	if %HealthBar.value != Global.HP:
		%HealthBar.value = Global.HP
		# create a Tween
		var tween =get_tree().create_tween()
		tween.tween_property(%DamageBar, "value", Global.HP, 1).set_trans(Tween.TRANS_EXPO)
	
	#the less health the set the self modulate to red
	if Global.HP<=%HealthBar.max_value*0.7:
		%HealthBar.self_modulate.r = 1-Global.HP/(%HealthBar.max_value)
		%HealthBar.self_modulate.g =  Global.HP/(%HealthBar.max_value)
