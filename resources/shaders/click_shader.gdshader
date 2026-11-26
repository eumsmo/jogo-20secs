shader_type spatial;
render_mode unshaded, depth_test_disabled;

uniform vec4 color: source_color = vec4(1.0);
uniform float radius : hint_range(0.0, 1.0) = 0.0;
uniform float tickness : hint_range(0.0, 1.0) = 0.1;

void fragment() {
	float half_radius = radius / 2.0;
	float alpha_mult = 1.0 - radius;
	
	float dist = distance(UV, vec2(0.5, 0.5));
	float edge = 1.0 - smoothstep(half_radius, half_radius - tickness, dist);
	float edge2 = 1.0 - step(half_radius, dist);
	float wave = edge * edge2 * (1.0-dist);
	
	ALBEDO.rgb = color.rgb;
	ALPHA = wave * alpha_mult;
}
