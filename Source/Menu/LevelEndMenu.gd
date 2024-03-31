extends CanvasLayer

var Data = preload("res://UI/Data.gd").new()
var Cred:bool = 0
 
func _ready():
	if Global.defeated:
		$Control/LostLabel.visible=1
		$Control/WonLabel.visible=0
		$Control/HBoxContainer/ButtonNext.visible=0
		$Control/HBoxContainer/ButtonNext.disabled=true
		print("lost")
	else:
		$Control/LostLabel.visible=0
		$Control/WonLabel.visible=1
		$Control/HBoxContainer/ButtonNext.visible=1
		$Control/HBoxContainer/ButtonNext.disabled=false
		print("win")
		Global.UnlockedLevel=min(max(Global.UnlockedLevel,Global.CurrentLevel+1),5)
		if (Global.CurrentLevel==5):
			Cred=true


func _on_button_quit_pressed():
	resume()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_button_play_pressed():
	resume()
	get_tree().change_scene_to_file(get_parent().Levels[Global.CurrentLevel])	
	
func resume():
	visible=false
	get_tree().paused=false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Engine.time_scale=1


func _on_button_next_pressed():
	resume()
	Global.CurrentLevel=(Global.CurrentLevel+1)%6
	
	match Global.UnlockedLevel:
		1:
			Global.UnlockedSpecial[0]=1
		2:
			Global.UnlockedWeapon[1]=1
		3:
			Global.UnlockedWeapon[2]=1
		4:
			Global.UnlockedSpecial[1]=1
		5:
			Global.UnlockedSpecial[2]=1

	if (Cred):
		get_tree().change_scene_to_file("res://credit.tscn")
		return

	get_tree().change_scene_to_file("res://UI/LoadMenu.tscn")
