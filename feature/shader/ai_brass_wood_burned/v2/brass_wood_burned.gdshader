shader_type spatial;

// --- Textures ---
uniform sampler2D texture_up : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D texture_other : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D detail_texture : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D noise_texture : source_color, filter_linear_mipmap, repeat_enable;

// --- UV Scale / Offset (world-space projection) ---
uniform vec2 uv_scale_up = vec2(1.0);
uniform vec2 uv_offset_up = vec2(0.0);
uniform vec2 uv_scale_other = vec2(1.0);
uniform vec2 uv_offset_other = vec2(0.0);
uniform vec2 uv_scale_detail = vec2(4.0);
uniform vec2 uv_offset_detail = vec2(0.0);

// --- Blend ---
uniform float threshold : hint_range(-1.0, 1.0) = 0.0;
uniform float blend_zone : hint_range(0.001, 1.0) = 0.1;

// --- Detail ---
uniform float detail_strength : hint_range(0.0, 1.0) = 0.3;

// --- Anti-repetition ---
uniform float warp_strength : hint_range(0.0, 0.3) = 0.08;
uniform float warp_scale : hint_range(0.01, 0.2) = 0.05;

// 3-tap rotation settings
uniform float scale_a : hint_range(0.5, 2.0) = 1.0;
uniform float scale_b : hint_range(0.5, 2.0) = 0.85;
uniform float scale_c : hint_range(0.5, 2.0) = 1.2;
uniform float rotation_b : hint_range(0.0, 360.0) = 45.0;
uniform float rotation_c : hint_range(0.0, 360.0) = 120.0;
uniform vec2 offset_b = vec2(7.3, 3.1);
uniform vec2 offset_c = vec2(-4.7, 11.9);
uniform float noise_blend_scale : hint_range(0.01, 0.3) = 0.08;

// --- Unlit toggle ---
uniform bool unlit = false;

vec2 best_planar_uv(vec3 world_pos, vec3 world_normal) {
	vec3 an = abs(world_normal);
	if (an.y >= an.x && an.y >= an.z) {
		return world_pos.xz;
	} else if (an.x >= an.z) {
		return world_pos.yz;
	} else {
		return world_pos.xy;
	}
}

vec2 rotate_uv(vec2 uv, float angle_deg) {
	float a = radians(angle_deg);
	float s = sin(a);
	float c = cos(a);
	return vec2(uv.x * c - uv.y * s, uv.x * s + uv.y * c);
}

vec4 sample_top_3tap(sampler2D tex, vec2 uv, sampler2D noise_tex) {
	// UV warp to break grid
	vec2 warp = (texture(noise_tex, uv * warp_scale).rg - 0.5) * 2.0 * warp_strength;
	vec2 warped = uv + warp;

	// Tap A: original scale, no rotation
	vec4 tap_a = texture(tex, warped * scale_a);

	// Tap B: different scale + rotation + offset
	vec2 uv_b = rotate_uv(warped, rotation_b) * scale_b + offset_b;
	vec4 tap_b = texture(tex, uv_b);

	// Tap C: different scale + rotation + offset
	vec2 uv_c = rotate_uv(warped, rotation_c) * scale_c + offset_c;
	vec4 tap_c = texture(tex, uv_c);

	// Noise-driven blend weights
	vec3 n = texture(noise_tex, uv * noise_blend_scale).rgb;
	float total = n.r + n.g + n.b + 0.001;
	vec3 w = n / total;

	return tap_a * w.r + tap_b * w.g + tap_c * w.b;
}

void fragment() {
	// TRUE world-space position/normal (independent of mesh local rotation and camera)
	vec3 world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec3 world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);

	// facing = +1 top, -1 bottom, 0 sides
	float facing = dot(world_normal, vec3(0.0, 1.0, 0.0));
	float topness = abs(facing);

	// --- UVs ---
	// Stable top/bottom mapping: always world XZ
	vec2 uv_up = world_pos.xz;

	// Bottom correction: rotate UV 90° so bottom aligns (avoid perceived 90° mismatch)
	if (facing < 0.0) {
		uv_up = vec2(-uv_up.y, uv_up.x); // +90°
	}

	uv_up = uv_up * uv_scale_up + uv_offset_up;

	// Other/detail mapping (planar selection in WORLD space)
	vec2 base_uv = best_planar_uv(world_pos, world_normal);
	vec2 uv_oth = base_uv * uv_scale_other + uv_offset_other;
	vec2 uv_det = base_uv * uv_scale_detail + uv_offset_detail;

	// --- Sampling ---
	vec4 col_up     = sample_top_3tap(texture_up, uv_up, noise_texture);
	vec4 col_other  = texture(texture_other, uv_oth);
	vec4 col_detail = texture(detail_texture, uv_det);

	// --- Blend ---
	float blend_factor = smoothstep(threshold - blend_zone, threshold + blend_zone, topness);
	vec3 base_color = mix(col_other.rgb, col_up.rgb, blend_factor);

	// --- Detail overlay ---
	if (detail_strength > 0.001) {
		vec3 overlay = mix(
			2.0 * base_color * col_detail.rgb,
			1.0 - 2.0 * (1.0 - base_color) * (1.0 - col_detail.rgb),
			step(0.5, base_color)
		);
		base_color = mix(base_color, overlay, detail_strength);
	}

	ALBEDO = base_color;

	if (unlit) {
		EMISSION = base_color;
		ALBEDO = vec3(0.0);
		SPECULAR = 0.0;
		ROUGHNESS = 1.0;
	}
}