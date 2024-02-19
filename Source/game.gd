extends Node2D

@onready var BG_pos=%BlueBlankBackground.position.y


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ForceQuit"):
		get_tree().quit()
		
	%BlueBlankBackground.position.y=%BlueBlankBackground.position.y+200.0*delta
		
	if %BlueBlankBackground.position.y>=0:
		%BlueBlankBackground.position.y= BG_pos


func _on_player_attack(WeaponType:int):
	print("Player Attack ",WeaponType)
	var Bullet = preload("res://bullet.tscn").instantiate()
	Bullet.position = $Player.position
	Bullet.rotation_degrees = -90
	add_child(Bullet)

