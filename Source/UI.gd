extends CanvasLayer

func _ready():
	%HealthBar.value = Global.HP
	%HealthBar.max_value = Global.HP
	%DamageBar.value = Global.HP
	%DamageBar.max_value = Global.HP

	%SpecialBar.value = Global.SP
	%SpecialBar.max_value = Global.SP
	
	%SpecialRecharge.value = Global.SP
	%SpecialRecharge.max_value = Global.SP
	
	%WeaponRecharge0.value = Global.AP
	%WeaponRecharge0.max_value = Global.AP

func _process(_delta):
	#health bar is progressbar
	healthBarUpdate()
	#special bar is progressbar
	%SpecialBar.value = Global.SP
	%SpecialRecharge.value = Global.SP
	%WeaponRecharge0.value = Global.AP

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
