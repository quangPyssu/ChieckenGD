extends Control

var isSetting:bool=0

func _on_setting_btn_pressed():
	print("setting")
	var tween:Tween = get_tree().create_tween()
	var tween2:Tween = get_tree().create_tween()
	
	if !isSetting:
		tween.tween_property($HBoxContainer2,"position" ,Vector2(-410.0,0.0 ),0.5 ).set_trans(Tween.TRANS_LINEAR)
		tween2.tween_property($HBoxContainer2,"size" ,Vector2(625.0,210.0 ),0.5 ).set_trans(Tween.TRANS_LINEAR)
		isSetting=1
		resetBtn()
		
	else:
		tween.tween_property($HBoxContainer2,"position" ,Vector2(0.0,0.0 ),0.5 ).set_trans(Tween.TRANS_LINEAR)
		tween2.tween_property($HBoxContainer2,"size" ,Vector2(210.0,210.0 ),0.5 ).set_trans(Tween.TRANS_LINEAR)
		isSetting=0
		resetBtn()
		
func resetBtn():
	for i in $HBoxContainer2.get_children():
		if isSetting:
			i.disabled=0
		else: 
			i.disabled=0
			
		i.button_pressed=0
