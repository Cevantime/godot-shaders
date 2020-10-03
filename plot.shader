shader_type canvas_item;

uniform float aspect_ratio = 16/9;
uniform float zoom:hint_range(0.1, 100.0) = 7.5;
uniform float thickness:hint_range(1., 100.) = 5.; 
uniform vec2 offset = vec2(0.);
uniform float fac = 1.;

vec4 plot(vec2 uv, float y, vec4 color, float t) {
	return smoothstep(t, 0., abs(uv.y + y)) * color;
}

void fragment() {
	vec4 color = vec4(0., 0.,0., 1.);
	vec2 uv = UV;
	
	float t = thickness * 0.001 * zoom;
	
	uv -= 0.5;
	uv.y *= aspect_ratio;
	
	uv *= zoom;
	
	uv += offset;
	
	vec4 green = vec4(0., 1., 0., 1.);

	color += plot(uv, fac + step(0., -uv.x) * uv.x * -fac, green, t);
	
	// draw axis
	if(length(color) <= 1.2) {
		color += plot(uv, 0, vec4(.0, .0, 1.0, 1.0), t / 2.);
		color += plot(uv.yx, 0, vec4(1.0, .0, .0, 1.0), t / 2.);
	}
	
	
	COLOR = color;
}