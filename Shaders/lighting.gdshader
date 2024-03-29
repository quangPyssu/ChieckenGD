shader_type canvas_item;

uniform float speed = 0;

uniform vec2 tiled_factor = vec2(1.0,1.0);

uniform vec2 offsetScale =vec2(1.25,1.25);
uniform vec2 amplitudeWave = vec2(0.012,0.01);
uniform vec2 timeScale = vec2(3.8,5.0);

void fragment() {
	vec2 tiled_uvs = UV*tiled_factor;
	vec2 waves_uv_offset;
	waves_uv_offset.x=cos(TIME*timeScale.x+(tiled_uvs.x+tiled_uvs.y)*offsetScale.x);
	waves_uv_offset.y=sin(TIME*timeScale.y+(tiled_uvs.x+tiled_uvs.y)*offsetScale.y);
	
	vec2 repeat=vec2(TIME*speed,0);
	
	//COLOR=vec4(waves_uv_offset,0.0,1.0);
	
	COLOR=texture(TEXTURE,tiled_uvs+waves_uv_offset*amplitudeWave+repeat);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
