shader_type canvas_item;

uniform float time_factor =0.5;
uniform vec2 amplitude = vec2(10.0,5.0);

uniform vec2 tiled_factor = vec2(5.0,3.0);

void vertex() {
	VERTEX.x +=  cos(time_factor*TIME+VERTEX.y+VERTEX.x)*amplitude.x ;
	VERTEX.y +=  sin(time_factor*TIME+VERTEX.x+VERTEX.y)*amplitude.y;
}

void fragment() {
	vec2 tiled_uvs = UV*tiled_factor;
	
	//COLOR=vec4(;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
