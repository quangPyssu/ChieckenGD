extends Control

var Levels: Array [String] = ["res://level0.tscn","res://level1.tscn","res://level2.tscn","res://level3.tscn"]

var Data = preload("res://UI/Data.gd").new()

func _ready():
	$StartBtn.set_disabled(true)
	
	for i in get_children():
		if i is Sprite2D:
			var a:Button=i.get_child(0)
			a.pressed.connect(_press_butt.bind(a.get_meta("Level"),a.get_meta("Ani")))

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


func _on_start_btn_pressed():
	Data.save_Data()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(Levels[Global.CurrentLevel])
