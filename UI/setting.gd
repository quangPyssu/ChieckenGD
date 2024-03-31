extends Control

var isSetting:bool=0

enum Orentation {
	left=0,drop=1
}

@export var isPausing:bool = false
@export var orientation:Orentation = Orentation.left

var Data = preload("res://UI/Data.gd").new()

var pos:Array [Vector2] = [Vector2(-615.0,0.0),Vector2(0.0,210.0)]
var siz:Array [Vector2] = [Vector2(625.0,210.0),Vector2(210.0,625.0)]

static var loaded: bool=false

func _ready():
	if !loaded:
		Data.load_Data()
		loaded=1
		
	var j:int =0
	for i in $Poppin/Popup/Volume.get_children():
		i.value_changed.connect(_on_value_changed.bind(i.get_meta("busIndex")))
		i.value=Global.Volume[j]
		_on_value_changed(Global.Volume[j],i.get_meta("busIndex"))
		j+=1
	
func _on_value_changed(value:float,bus_index:int):
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
	Global.Volume[bus_index]=value
	
func _on_setting_btn_pressed():	
	stretch_retract()
		
	resetBtn()

func stretch_retract():
	
	if !isPausing:
		var tween:Tween = get_tree().create_tween()
		tween.set_parallel(true)
		
		if !isSetting:
			tween.tween_property($HBoxContainer2,"position" ,pos[orientation],0.5 ).set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($HBoxContainer2,"size" ,siz[orientation],0.5 ).set_trans(Tween.TRANS_LINEAR)
			isSetting=1
			
		else:
			tween.tween_property($HBoxContainer2,"position" ,Vector2(0.0,0.0 ),0.5 ).set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($HBoxContainer2,"size" ,Vector2(210.0,210.0 ),0.5 ).set_trans(Tween.TRANS_LINEAR)
			isSetting=0
	else:
		if !isSetting:
			$HBoxContainer2.position=pos[orientation]
			$HBoxContainer2.size=siz[orientation]
			isSetting=1
			
		else:
			$HBoxContainer2.position=Vector2(0.0,0.0)
			$HBoxContainer2.size=Vector2(210.0,210.0)
			isSetting=0

func resetBtn():
	
	for i in $HBoxContainer2.get_children():
		if isSetting:
			i.disabled=0
		else: 
			i.disabled=0
			
	$HBoxContainer2/VolumeBtn.button_pressed=0

func _on_volume_btn_toggled(toggled_on):
	if toggled_on:
		$Poppin/Popup.global_position=Global.ScreenSize/2.0-$Poppin/Popup.size/(2.0*$Poppin/Popup.scale)
	else:
		$Poppin/Popup.global_position=Vector2(-2000.0,-2000.0)

func _on_ratio_btn_toggled(toggled_on):
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func _on_tree_exited():
	pass
	#Data.save_Data()

func _on_info_btn_toggled(toggled_on):
	if toggled_on:
		$Poppin/Credit.global_position=Global.ScreenSize/2.0-$Poppin/Credit.size/(2.0*$Poppin/Credit.scale)+Vector2(100.0,0)
	else:
		$Poppin/Credit.global_position=Vector2(-2000.0,-2000.0)
