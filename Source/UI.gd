extends CanvasLayer

var Weapon:Array [TextureRect] 
var CurWeapon:int = 0

func _ready():
	%HealthBar.value = Global.HP
	%HealthBar.max_value = Global.HP
	%DamageBar.value = Global.HP
	%DamageBar.max_value = Global.HP

	%SpecialBar.value = Global.SP
	%SpecialBar.max_value = Global.SP
	
	%SpecialRecharge.value = Global.SP
	%SpecialRecharge.max_value = Global.SP
	%SpecialRecharge.step = 0.1
	
	var cnt:int =0
	for i in $Control/HBoxContainer/Weapons.get_children():
		Weapon.append(i)
		i.get_node("WeaponRecharge").max_value = Global.WeaponTime[Global.EquippedWeapon[cnt]]
		i.get_node("WeaponRecharge").value = Global.WeaponTime[Global.EquippedWeapon[cnt]]
		i.get_node("WeaponRecharge").step=0.05
		cnt+=1
		
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
		$Control/HBoxContainer/SpecialSprite/SpecialSelect.visible=1
	else: 
		$Control/HBoxContainer/SpecialSprite/SpecialSelect.visible=0
		
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
