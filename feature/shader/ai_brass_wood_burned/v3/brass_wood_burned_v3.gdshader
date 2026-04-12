shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform sampler2D tex_updown : source_color; // Texture A
uniform sampler2D tex_side   : source_color; // Texture B

uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0.0, 0.0);

uniform float up_threshold : hint_range(0.0, 1.0) = 0.75;
uniform float feather : hint_range(0.0, 0.5) = 0.05;

uniform bool unlit = false;
uniform float unlit_energy : hint_range(0.0, 8.0) = 1.0;

varying float v_up_mask;

void vertex() {
    // Object normal -> world normal
    vec3 world_n = normalize(MODEL_NORMAL_MATRIX * NORMAL);

    float y = abs(world_n.y);

    float t0 = max(0.0, up_threshold - feather);
    float t1 = min(1.0, up_threshold + feather);
    v_up_mask = smoothstep(t0, t1, y);
}

void fragment() {
    vec2 uv = UV * uv_scale + uv_offset;

    vec3 col_updown = texture(tex_updown, uv).rgb;
    vec3 col_side   = texture(tex_side, uv).rgb;

    ALBEDO = mix(col_side, col_updown, v_up_mask);
}

void light() {
    if (unlit) {
        DIFFUSE_LIGHT = ALBEDO * unlit_energy;
        SPECULAR_LIGHT = vec3(0.0);
    } else {
        float ndotl = max(dot(NORMAL, LIGHT), 0.0);
        DIFFUSE_LIGHT += ALBEDO * LIGHT_COLOR * ndotl;
    }
}