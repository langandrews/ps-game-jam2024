shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec2 center = vec2(0.5, 0.5);
	float force = 0.01;
	float size = 0.4;
	float width = 0.1;
	
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
	
	float mask = 1.0 - smoothstep(size - width, size, length(scaledUV - center));
	mask *= smoothstep(size - width - width, size - width, length(scaledUV - center));
	
	vec2 disp = normalize(SCREEN_UV - center) * force * mask;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp);
	//COLOR.rgb = vec3(mask);
	
	//float zoom = (sin(TIME / 100.0)) / 2.0 + 0.5;
	//vec2 centerOffset = (SCREEN_UV - center);
	//
	//vec2 centerDistance = centerOffset.x * centerOffset.r + centerOffset.g * centerOffset.g;
	//
	//vec2 newOffset = centerOffset * zoom;
	//COLOR = vec4(SCREEN_UV - disp, 0.0, 1.0);
	//COLOR.rgb = textureLod(SCREEN_TEXTURE, SCREEN_UV, amount).rgb;
	//COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	//vec2 uv = clamp(centerOffset + center, vec2(0.0, 0.0), vec2(1.0, 1.0));
	//COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
	
}
