extends Control

var Buttons:Array [TextureButton] = []
var Game:Array [PackedScene] = [preload("res://level0.tscn")]

var Levels: Array [String] = ["res://level0.tscn","res://level1.tscn","res://Level2.tscn","res://Level3.tscn","res://Level4.tscn","res://Level5.tscn"]

var Data = preload("res://UI/Data.gd").new()

var loading:bool = false
var loaded:float = 0

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
	
	if loading:
		loaded = ResourceLoader.load_threaded_get_status(Levels[Global.CurrentLevel])

		if loaded == ResourceLoader.THREAD_LOAD_LOADED:
			await get_tree().create_timer(0.2).timeout
			var newScene = ResourceLoader.load_threaded_get(Levels[Global.CurrentLevel])
			get_tree().change_scene_to_packed(newScene)
	
func BTN_Hover():
	$AudioStreamPlayer.set_stream(preload("res://Asset/Menu/Sfx/ui-click.mp3"))
	$AudioStreamPlayer.play()

func _on_exit_btn_pressed():
	_on_tree_exited()
	get_tree().quit()
	

func _on_start_btn_pressed():
	await get_tree().create_timer(0.5).timeout
	ResourceLoader.load_threaded_request(Levels[Global.CurrentLevel])
	loading=true

var isSetting:bool=0


func _on_map_btn_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://UI/LoadMenu.tscn")

func _on_tree_exited():
	Data.save_Data()
