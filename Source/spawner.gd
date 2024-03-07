extends Area2D

@export var BetweenSpawn:float = 5.0
@export var SpawnCnt:int = 10

enum WhatSpawnerType {
	EntitySpawner,BulletSpawner
}

var SpawnTimer:Timer=null
@export var WhatSpawning:Global.SpawnType = Global.SpawnType.Egg
@export var direction:Vector2 = Vector2(10,10).normalized()
var WhatSpawner:WhatSpawnerType = WhatSpawnerType.BulletSpawner

var theWhat:PackedScene = null

var theBox:CollisionShape2D
var orgPos:Vector2 

var EntitySet:Array [entity] = []
var BulletSet:Array [bullet] = []

func _ready():
	theBox=get_child(get_child_count()-1)
	orgPos=theBox.global_position-Vector2(theBox.shape.size.x,theBox.shape.size.y)/2
	
	theBox.position=-position
	direction=direction.normalized()
	
	SpawnTimer=$SpawnTimer
	SpawnTimer.wait_time=BetweenSpawn
	
	match WhatSpawning:
		Global.SpawnType.Egg:
			WhatSpawner=WhatSpawnerType.BulletSpawner
			theWhat=preload("res://Egg.tscn")
			
		Global.SpawnType.Astroid:
			WhatSpawner=WhatSpawnerType.BulletSpawner
			theWhat=preload("res://Astroid.tscn")
		
		Global.SpawnType.EnemyChicken:
			WhatSpawner=WhatSpawnerType.EntitySpawner
			theWhat=preload("res://Enemy_Chicken.tscn")
	
func spawn():
	#random position in Spawn Zone
	for i:int in SpawnCnt:
		var ranPos=Vector2(randf_range(0,theBox.shape.size.x),randf_range(0,theBox.shape.size.y))+orgPos
		if WhatSpawner==WhatSpawnerType.BulletSpawner:
			var A:bullet = theWhat.instantiate()
			get_node("/root/Game/Projectiles").add_child(A)
			A.direction=direction
			A.global_position = ranPos
			if (direction!=Vector2.ZERO):
				A.rotation=atan(direction.x/direction.y)

func _on_spawn_timer_timeout():
	spawn()
