shader_type spatial;

uniform sampler2D texture_up : source_color, filter_linear_mipmap;
uniform sampler2D texture_other : source_color, filter_linear_mipmap;
uniform float threshold : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    // World-space normal
    vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;

    // Dot with world up (Y axis)
    float up_dot = dot(normalize(world_normal), vec3(0.0, 1.0, 0.0));

    // Sample both textures
    vec4 tex_up = texture(texture_up, UV);
    vec4 tex_other = texture(texture_other, UV);

    // Pick texture based on whether the face points up
    vec4 result = mix(tex_other, tex_up, step(threshold, up_dot));

    ALBEDO = result.rgb;
}
