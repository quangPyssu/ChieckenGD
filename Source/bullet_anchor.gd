extends entity

class_name B_Anchor

var bulletSet: Array[bullet] = []
var bulletCount: float = 10

var size:float = 200.0
var isOdd:Vector2 = Vector2(1.5,1.5)
var sideSize:int 

var bulletMax: float = 10.0
var Type:Global.SpawnType = Global.SpawnType.Egg
var pattern:Global.patternType = Global.patternType.CircleShape

var Dying:bool = false

func _Rready(theType:Global.SpawnType,thepattern:Global.patternType,theCnt: float=10.0,theSize:float = 200.0,DeathTime: float=5.0):
	Type = theType
	pattern = thepattern
	bulletMax = theCnt
	size = theSize
	
	generateBullets()

	for i in get_children():
		if i is bullet:
			bulletSet.append(i)

	bulletCount = bulletSet.size()
	bulletMax = bulletCount

	inClampedScreen = true	
	
	var Shaping = CircleShape2D.new()
	$PhysicBox.set_shape(Shaping)
	$PhysicBox.shape.radius = size
	
	sideSize = sqrt(bulletMax)
	isOdd=Vector2(0.5,0.5)*(sideSize-1)

	direction = Vector2(-1,0)

	setUp()
	$DeathTimer.wait_time=DeathTime

func generateBullets():
	#generate entities based on the bulletMax
	var preload_bullet: PackedScene = null

	if Type == Global.SpawnType.Egg:
		preload_bullet = preload("res://Egg.tscn")

	for i in range(bulletMax):
		var abullet:bullet = null
		abullet = preload_bullet.instantiate()
		add_child(abullet)

func setUp():
	for i in range(bulletMax):
		var abullet:bullet = bulletSet[i]
		if pattern == Global.patternType.CircleShape:
			var tmp:float=i/bulletMax*360
			abullet.position = Vector2(sin(deg_to_rad(tmp))*size,cos(deg_to_rad(tmp))*size)
			abullet.rotation_degrees = tmp
		elif pattern == Global.patternType.SquareShape:
			abullet.position = Vector2(float(i%sideSize), float(i/sideSize))*(size/2)-Vector2(size,size)
			
func addBulDir(BulSpeed:int):
	for i in range(bulletMax):
		var abullet:bullet = bulletSet[i]
		abullet.direction = Vector2.ZERO
		abullet.speed=BulSpeed

func _process(_delta):
	if $DeathTimer.time_left<flickerTime and !Dying:
		Dying=1
		for i:int in range(0, flickerTime/0.2):
			modulate.a = 0.5
			await get_tree().create_timer(0.1).timeout
			modulate.a = 1
			await get_tree().create_timer(0.1).timeout

func _on_death_timer_timeout():
	queue_free()
