extends Area2D

class_name bullet

var speed: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var accelaration: float = 0.0
var direction: Vector2 = Vector2(0,0)
@export var damage: int = 1
@export var canBreak: bool = 0
@export var HP: int = 10

var broken:bool = false

@export var inClampedScreen: bool = true

func _process(delta):
	speed += accelaration * delta
	velocity = direction * speed
	global_position += velocity * delta

	if inClampedScreen: #clamp in the screen		
		global_position.x = clamp(global_position.x, 0, get_viewport().size.x)
		global_position.y = clamp(global_position.y, 0, get_viewport().size.y)
	else: #destroy when out of screen
		if global_position.x < -300 or global_position.x > get_viewport().size.x+300 or global_position.y < -300 or global_position.y > get_viewport().size.y+300:
			broken=true
		
	if HP<=0:
		kill()
		HP=1
		
	if broken and !$BulletSound.is_playing():
		queue_free()

func _on_area_entered(area:Area2D):
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
	elif "HP" in area:
		if area.HP>0:
			area.HP-=damage	

	kill()

func kill():
	if canBreak and !broken:
		broken=true
		%AnimationCenter.hide()
		$HitBox.queue_free()
