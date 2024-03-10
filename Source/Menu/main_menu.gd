extends Control

var Buttons:Array [TextureButton] = []
var Game:Array [PackedScene] = [preload("res://level0.tscn")]

func _ready():
	get_viewport().size=Global.ScreenSize
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
	get_tree().quit()
	

func _on_start_btn_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(Game[0])
