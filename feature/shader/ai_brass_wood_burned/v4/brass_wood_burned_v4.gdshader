shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back;

uniform sampler2D tex_updown : source_color; // Texture A (up or down in the mesh)
uniform sampler2D tex_side   : source_color; // Texture B (sides in the mesh)

uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0.0, 0.0);

// If abs(local_normal.y) >= up_threshold => tex_updown, else tex_side
uniform float up_threshold : hint_range(0.0, 1.0) = 0.75;
uniform float feather : hint_range(0.0, 0.5) = 0.05;

// 0 = lit, 1 = unlit
uniform bool unlit = false;
uniform float unlit_energy : hint_range(0.0, 8.0) = 1.0;

varying float v_up_mask;

void vertex() {
    // NORMAL is in object/local space (i.e., defined by the mesh itself)
    vec3 n_local = normalize(NORMAL);

    float y = abs(n_local.y);

    float t0 = max(0.0, up_threshold - feather);
    float t1 = min(1.0, up_threshold + feather);
    v_up_mask = smoothstep(t0, t1, y);
}

void fragment() {
    vec2 uv = UV * uv_scale + uv_offset;

    vec3 colA = texture(tex_updown, uv).rgb;
    vec3 colB = texture(tex_side,   uv).rgb;

    ALBEDO = mix(colB, colA, v_up_mask);
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