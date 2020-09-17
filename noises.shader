shader_type canvas_item;

vec2 hash(vec2 p) {
	p = vec2(dot(p,vec2(127.1, 311.7)),
	         dot(p,vec2(269.5, 183.3)));

	return 2.0 * fract(sin(p) * 43758.5453123) - 1.0;
}

float noise(vec2 p, float t)
{
   	vec2 i = floor(p);
   	vec2 f = fract(p);
	
//	vec2 u = f;
//	vec2 u = f * f * (3.0 - 2.0 * f);
	vec2 u = f * f * f * (10.0 + f * (6.0 * f - 15.0));
//	vec2 u = f * f * f * f * (f * (f * (-20.0 * f + 70.0) - 84.0) + 35.0);

   	mat2 R = mat2(vec2(cos(t), -sin(t)), vec2(sin(t), cos(t)));

	return 2.0 * mix(mix(dot(hash(i + vec2(0,0)) * R, (f - vec2(0,0))), 
                             dot(hash(i + vec2(1,0)) * R, (f - vec2(1,0))), u.x),
                         mix(dot(hash(i + vec2(0,1)) * R, (f - vec2(0,1))), 
                             dot(hash(i + vec2(1,1)) * R, (f - vec2(1,1))), u.x), u.y);
}

float turb(vec2 p, float t) {
	float f = 0.0;
	
 	mat2 m = mat2(vec2(1.6,  1.2), vec2(-1.2,  1.6));
 	f  = 0.5000 * noise(p, t); p = m*p;
	f += 0.2500 * noise(p, t * -2.1); p = m*p;
	f += 0.1250 * noise(p, t * 4.1); p = m*p;
	f += 0.0625 * noise(p, t * -8.1); p = m*p;
	return f / .9375; 
}