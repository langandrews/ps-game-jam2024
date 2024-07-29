shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest, repeat_disable;

uniform vec2 center = vec2(0.5, 0.65);
uniform float force = 0.015;
uniform float size = 0.0;
uniform float width = 0.0;

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
	
	float donutMask = 1.0 - smoothstep(size - width, size, length(scaledUV - center));
	donutMask *= smoothstep(size - width - width, size - width, length(scaledUV - center));
	
	vec2 warpEffect = normalize(SCREEN_UV - center) * force * donutMask;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - warpEffect);
	
	float invertWeight = min(donutMask, 0.1);
	COLOR.r = COLOR.r * (1.0 - invertWeight) + (1.0 - COLOR.r) * invertWeight;
	COLOR.g = COLOR.g * (1.0 - invertWeight) + (1.0 - COLOR.g) * invertWeight ;
	COLOR.b = COLOR.b * (1.0 - invertWeight)+ (1.0 - COLOR.b) * invertWeight;
}
