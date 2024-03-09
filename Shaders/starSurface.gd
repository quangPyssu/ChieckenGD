@tool
extends Sprite2D

func calculate_aspect_ratio():
	#$shader_parameter/aspect_ratio
	material.set_shader_parameter("aspect_ratio",scale.x/scale.y)


func _on_item_rect_changed():
	calculate_aspect_ratio()

func _process(delta):
	$PointLight2D.position.x-=delta*10.0
	if $PointLight2D.position.x<=-100.0:
		$PointLight2D.position.x=100.0
