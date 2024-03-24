extends Control

var Buttons:Array [TextureButton] = []
var Game:Array [PackedScene] = [preload("res://level0.tscn")]

var Levels: Array [String] = ["res://level0.tscn","res://level1.tscn","res://level2.tscn","res://level3.tscn","res://level4.tscn"]

var Data = preload("res://UI/Data.gd").new()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#get_viewport().size=Global.ScreenSize
	
	Buttons.append(%StartBtn)
	Buttons.append(%MapBtn)
	Buttons.append(%ExitBtn)
	
	for i in Buttons:
		i.connect("pressed",BTN_Hover)

func _process(_delta):
	$BtnLight.global_position=get_global_mouse_position()
	
func BTN_Hover():
	$AudioStreamPlayer.set_stream(preload("res://Asset/Menu/Sfx/ui-click.mp3"))
	$AudioStreamPlayer.play()

func _on_exit_btn_pressed():
	_on_tree_exited()
	get_tree().quit()
	

func _on_start_btn_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(Levels[Global.CurrentLevel])


var isSetting:bool=0


func _on_map_btn_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://UI/LoadMenu.tscn")

func _on_tree_exited():
	Data.save_Data()
