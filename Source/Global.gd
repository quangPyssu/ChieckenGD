extends Node

const ScreenSize:Vector2 = Vector2(1920, 1080)

var defeated:bool = false
var LevelEnd:bool = false

var HP:float = 100.0
var maxHP:float = 100.0

var SP:float = 30.0
var maxSP:float = 30.0

var AP:float = 0.5
var maxAP:float = 0.5

var save_game_path:String = "res://Data/data.save"

var WeaponTime: Array[float] = [0.5,2.0,0.0,0.0]
var SpecialTime: Array[float] = [10.0,0.0,30.0,0.0]

#Data for file I/O
####################
var UnlockedWeapon:Array[bool] = [1,0,0,0]
var UnlockedSpecial:Array[bool] = [1,1,0,0]
var CurrentLevel:int = 0
var UnlockedLevel:int = 4
var Volume:Array [float] = [1.0,0.5,0.5,0.4]
####################

var EquippedWeapon: Array[int] =[0,1]
var CurrentWeapon:int=0

var WeaponType:int = 0
var SpecialType:int = 2

var PlayerPos:Vector2

var isShaking:bool = 0
var shakeStrength:int = 7


enum patternType {
	CircleShape,SquareShape,Hline,Vline
}

enum BulletSpin{
	SprialOut
}

enum SpawnType {
	Egg, EnemyChicken, Astroid , SmallLaser, UFOBullet,Chick
}

func Swap(a:float,b:float):
	var c:float = a
	a=b
	b=c
