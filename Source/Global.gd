extends Node

const ScreenSize:Vector2 = Vector2(1920, 1080)

var defeated:bool = false

var HP:float = 10.0
var maxHP:float = 10.0

var SP:float = 30.0
var maxSP:float = 30.0

var AP:float = 0.5
var maxAP:float = 0.5

var WeaponTime: Array[float] = [0.5,2,0.0,0.0]
var SpecialTime: Array[float] = [30.0,0.0,0.0,0.0]

var EquippedWeapon: Array[int] =[0,1]
var CurrentWeapon:int=0

var WeaponType:int = 0
var SpecialType:int = 0

var PlayerPos:Vector2


enum patternType {
	CircleShape,SquareShape
}

enum BulletSpin{
	SprialOut
}

enum SpawnType {
	Egg, EnemyChicken
}
