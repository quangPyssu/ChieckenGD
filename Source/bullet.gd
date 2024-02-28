extends Area2D

class_name bullet

var BaseSpeed: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var accelaration: float = 0.0
var direction: Vector2 = Vector2(0,0)
@export var damage: int = 1
@export var HP: int = 1
@export var BounceCount: int = 0

@export var inClampedScreen: bool = true

func _process(delta):
	BaseSpeed += accelaration * delta
	velocity = direction * BaseSpeed
	global_position += velocity * delta

	if inClampedScreen: #clamp in the screen		
		global_position.x = clamp(global_position.x, 0, get_viewport().size.x)
		global_position.y = clamp(global_position.y, 0, get_viewport().size.y)
	else: #destroy when out of screen
		if global_position.x < -300 or global_position.x > get_viewport().size.x+300 or global_position.y < -300 or global_position.y > get_viewport().size.y+300:
			queue_free()
			
	if HP <= 0 and !$BulletSound.is_playing():
		queue_free()

func _on_area_entered(area:Area2D):
	if HP>0:
		if area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(damage)
		HP-=1
		
		if HP<=0: 
			%AnimationCenter.hide()
