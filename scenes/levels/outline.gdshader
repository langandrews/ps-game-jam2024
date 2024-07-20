shader_type canvas_item;
render_mode unshaded;

uniform bool Smooth = true;
uniform float width : hint_range(0.0, 64) = 1.0;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform int pixel_size : hint_range(1, 10) = 4;
uniform float width_speed :hint_range(0.1, 10) = 1;

void fragment()
{
    float _width = width + ((sin(TIME*width_speed) + 1.0) -2.0) * 10.0;
    vec2 unit = (1.0/float(pixel_size) ) / vec2(textureSize(TEXTURE, 0));
    vec4 pixel_color = texture(TEXTURE, UV);
    if (pixel_color.a == 0.0) {
        pixel_color = pixel_color;
    } else {
		pixel_color = outline_color;
	}
    COLOR = pixel_color;
}