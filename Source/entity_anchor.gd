extends entity

var entitySet: Array[entity] = []
var entityCount: float = 10

var sideSize:int
var isOdd:Vector2 = Vector2(1.5,1.5)

@export var size:float 

@export var entityMax: float = 10.0
@export var Type:Global.SpawnType = Global.SpawnType.EnemyChicken
@export var pattern:Global.patternType = Global.patternType.CircleShape

func _ready():
	#why is entityMax 0?
	generateEntities()

	for i in get_children():
		if i is entity:
			entitySet.append(i)

	entityCount = entitySet.size()
	entityMax = entityCount
	
	sideSize = sqrt(entityMax)
	isOdd=Vector2(0.5,0.5)*(sideSize-1)

	var Shaping = CircleShape2D.new()
	$PhysicBox.set_shape(Shaping)
	$PhysicBox.shape.radius = size
	direction = Vector2(-1,0)

	setUp()
	super._ready()

func generateEntities():
	#generate entities based on the entityMax
	var preload_Entity: PackedScene = null

	if Type == Global.SpawnType.EnemyChicken:
		preload_Entity = preload("res://Enemy_Chicken.tscn")

	for i in range(entityMax):
		var aEntity:entity = null
		aEntity = preload_Entity.instantiate()
		add_child(aEntity)

func setUp():
	#depending on the type of pattern, position the entities 
	for i in range(entityMax):
		var aEntity:entity = entitySet[i]
		aEntity.inClampedScreen=false
		aEntity.direction = Vector2.ZERO
		if pattern == Global.patternType.CircleShape:
			var tmp:float=i/entityMax*360
			#make the entities in a circle around the Anchor(this node)
			aEntity.position = Vector2(sin(deg_to_rad(tmp))*size,cos(deg_to_rad(tmp))*size)
		elif pattern == Global.patternType.SquareShape:
			aEntity.position = (Vector2(float(i%sideSize), float(i/sideSize))-isOdd)*size/2

func _process(_delta):
	if entityCount==0:
		queue_free()

	if Input.is_action_just_pressed("TestButton-"):
		gotoPosition(Global.PlayerPos, speed)
