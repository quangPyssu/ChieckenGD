extends bullet

var ani:AnimationPlayer

func _ready():
	ani=$AnimationCenter/AnimationPlayer
	ani.play("FallingStar")
	ani.queue("SkyFall")

func shake(strength:int):
	Global.shakeStrength+=strength

func _on_area_entered(area:Area2D):
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
