shader_type canvas_item;

uniform vec4 modulate_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 1.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (tex_color.a > 0.0) {
        COLOR = tex_color * modulate_color;
    } else {
        vec2 size = TEXTURE_PIXEL_SIZE * outline_width;
        float alpha = 
            texture(TEXTURE, UV + vec2(size.x, 0.0)).a +
            texture(TEXTURE, UV + vec2(-size.x, 0.0)).a +
            texture(TEXTURE, UV + vec2(0.0, size.y)).a +
            texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
        
        if (alpha > 0.0) {
            COLOR = outline_color;
        } else {
            discard;
        }
    }
}
