shader_type canvas_item;

uniform float time_factor =0.5;
uniform vec2 amplitude = vec2(1.0,1.0);

uniform vec2 tiled_factor = vec2(3.0,1.0);
uniform float aspect_ratio = 1.0;

uniform vec2 offsetScale =vec2(0.75,0.5);
uniform vec2 amplitudeWave = vec2(0.2,0.005);
uniform vec2 timeScale = vec2(0.7,0.5);

void vertex() {
	//VERTEX.x +=  cos(time_factor*TIME+VERTEX.y+VERTEX.x)*amplitude.x ;
	//VERTEX.y +=  sin(time_factor*TIME+VERTEX.x+VERTEX.y)*amplitude.y;
}

void fragment() {
	vec2 tiled_uvs = UV*tiled_factor;
	tiled_uvs.x*=aspect_ratio;
	vec2 waves_uv_offset;
	waves_uv_offset.x=cos(TIME*timeScale.x+(tiled_uvs.x+tiled_uvs.y)*offsetScale.x);
	waves_uv_offset.y=sin(TIME*timeScale.y+(tiled_uvs.x+tiled_uvs.y)*offsetScale.y);
	
	//COLOR=vec4(waves_uv_offset,0.0,1.0);
	COLOR=texture(TEXTURE,tiled_uvs+waves_uv_offset*amplitudeWave);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
