extends Node

const ScreenSize:Vector2 = Vector2(1920, 1080)

var defeated:bool = false

var HP:float = 10.0
var maxHP:float = 10.0

var SP:float = 30
var maxSP:float = 30

var PlayerPos:Vector2

enum patternType {
	CircleShape,SquareShape
}

enum BulletSpin{
	SprialOut
}

enum bulletType {
	Egg
}

enum entityType {
	EnemyChicken
}
