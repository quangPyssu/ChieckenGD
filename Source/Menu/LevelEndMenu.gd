extends CanvasLayer
 
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
	print("NextLvel")
	get_tree().change_scene_to_file(Global.Levels[(Global.CurrentLevel+1)%5])
