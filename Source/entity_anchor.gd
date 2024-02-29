extends entity

var entitySet: Array[entity] = []
var entityCount: float = 10

@export var size:float = 200.0

@export var entityMax: float = 10.0
@export var Type:Global.entityType = Global.entityType.EnemyChicken
@export var pattern:Global.patternType = Global.patternType.CircleShape

func _ready():
	#why is entityMax 0?
	generateEntities()

	for i in get_children():
		if i is entity:
			entitySet.append(i)

	entityCount = entitySet.size()
	entityMax = entityCount

	inClampedScreen = true	

	$PhysicBox.shape.radius = size

	direction = Vector2(-1,0)

	setUp()
	super._ready()

func generateEntities():
	#generate entities based on the entityMax
	var preload_Entity: PackedScene = null

	if Type == Global.entityType.EnemyChicken:
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
			aEntity.rotation_degrees = tmp
		elif pattern == Global.patternType.SquareShape:
			var sideSize:int = sqrt(entityMax)
			
			aEntity.position = Vector2(float(i%sideSize), float(i/sideSize))*(size/2)-Vector2(size,size)/2

func _process(_delta):
	if entityCount==0:
		queue_free()

	if Input.is_action_just_pressed("TestButton-"):
		
		gotoPosition(Global.PlayerPos, speed)
