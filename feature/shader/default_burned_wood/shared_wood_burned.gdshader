shader_type spatial;
render_mode unshaded, blend_mix, depth_draw_opaque, cull_back;

/*
This shader projects textures in LOCAL (object) space:
- Top/Bottom faces use planar projection on XZ.
- Side faces use triplanar projection (blend of 3 projections).
- A hard threshold chooses top/bottom vs sides based on abs(normal.y).
*/

uniform sampler2D top_bottom_albedo_texture : source_color, filter_nearest_mipmap;
uniform sampler2D side_albedo_texture       : source_color, filter_nearest_mipmap;

// TOP/BOTTOM UV SETTINGS
uniform float top_bottom_uv_tiling : hint_range(0.0001, 1000.0) = 1.0;
uniform vec2  top_bottom_uv_offset = vec2(0.0, 0.0);
uniform float top_bottom_uv_rotation_radians : hint_range(-6.283185, 6.283185) = 0.0;

// SIDE UV SETTINGS
uniform float side_uv_tiling_u : hint_range(0.0001, 1000.0) = 1.0;
uniform float side_uv_tiling_v : hint_range(0.0001, 1000.0) = 1.0;
uniform vec2  side_uv_offset = vec2(0.0, 0.0);
uniform float side_uv_rotation_radians : hint_range(-6.283185, 6.283185) = 0.0;

// TOP VS SIDE SELECTION
// If abs(normal.y) >= this value, we use the top/bottom texture; otherwise we use the side texture.
uniform float top_bottom_face_normal_y_abs_threshold : hint_range(0.0, 1.0) = 0.75;

varying float top_bottom_face_mask;
varying vec3  local_vertex_position;
varying vec3  local_vertex_normal;

vec2 rotate_uv_2d(vec2 uv, float angle_radians) {
    float c = cos(angle_radians);
    float s = sin(angle_radians);
    return vec2(c * uv.x - s * uv.y, s * uv.x + c * uv.y);
}

vec2 compute_top_bottom_uv(vec2 uv_unscaled) {
    vec2 uv = uv_unscaled * top_bottom_uv_tiling;
    uv = rotate_uv_2d(uv, top_bottom_uv_rotation_radians);
    uv += top_bottom_uv_offset;
    return uv;
}

vec2 compute_side_uv(vec2 uv_unscaled) {
    vec2 uv = uv_unscaled * vec2(side_uv_tiling_u, side_uv_tiling_v);
    uv = rotate_uv_2d(uv, side_uv_rotation_radians);
    uv += side_uv_offset;
    return uv;
}

vec3 sample_side_texture_triplanar(sampler2D texture_to_sample, vec3 position_local, vec3 normal_local) {
    vec3 normal_abs = abs(normalize(normal_local));
    normal_abs /= max(normal_abs.x + normal_abs.y + normal_abs.z, 1e-6);

    vec2 uv_projected_from_x = vec2(position_local.z, position_local.y);
    vec2 uv_projected_from_y = vec2(position_local.x, position_local.z);
    vec2 uv_projected_from_z = vec2(position_local.x, position_local.y);

    uv_projected_from_x = compute_side_uv(uv_projected_from_x);
    uv_projected_from_y = compute_side_uv(uv_projected_from_y);
    uv_projected_from_z = compute_side_uv(uv_projected_from_z);

    vec3 color_from_x = texture(texture_to_sample, uv_projected_from_x).rgb;
    vec3 color_from_y = texture(texture_to_sample, uv_projected_from_y).rgb;
    vec3 color_from_z = texture(texture_to_sample, uv_projected_from_z).rgb;

    return color_from_x * normal_abs.x + color_from_y * normal_abs.y + color_from_z * normal_abs.z;
}

void vertex() {
    local_vertex_position = VERTEX;
    local_vertex_normal   = normalize(NORMAL);

    float normal_y_abs = abs(local_vertex_normal.y);
    top_bottom_face_mask = (normal_y_abs >= top_bottom_face_normal_y_abs_threshold) ? 1.0 : 0.0;
}

void fragment() {
    vec2 top_bottom_uv_unscaled = vec2(local_vertex_position.x, local_vertex_position.z);
    vec2 top_bottom_uv = compute_top_bottom_uv(top_bottom_uv_unscaled);
    vec3 top_bottom_color = texture(top_bottom_albedo_texture, top_bottom_uv).rgb;

    vec3 side_color = sample_side_texture_triplanar(
        side_albedo_texture,
        local_vertex_position,
        local_vertex_normal
    );

    ALBEDO = mix(side_color, top_bottom_color, top_bottom_face_mask);
}