shader_type canvas_item;

uniform float dist_limit : hint_range(0.0, 1.0) = 1.0;
uniform bool invert_alpha = false;

void fragment() {
	float dist = distance(UV, vec2(0.5,0.5));
	bool show = dist > dist_limit;
	if (invert_alpha) show = !show;
	 
	COLOR.a = show ? 1.0 : 0.0;
}