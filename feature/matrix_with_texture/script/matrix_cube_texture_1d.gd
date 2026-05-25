class_name MatrixCubeTexture1D
extends Node3D

signal on_texture_material_updated(index:int, material_surface:Material)
signal on_texture_updated(texture :Texture2D)

@export var material_to_duplicate: StandardMaterial3D
@export var material_duplicated: StandardMaterial3D
@export var texture: Texture2D
@export var line_element :int = 32
@export var pixels_per_cell :int = 8
@export var use_random_at_ready:bool = true


@export var color_for_true:Color = Color(0, 1, 0, 1)
@export var color_for_false:Color = Color(1, 0, 0, 1)


func convert_1d_to_2d(index_1d:int) -> Vector2i:
	var x:int = index_1d % line_element
	var y:int = index_1d / line_element
	return Vector2i(x, y)

func convert_2d_to_1d(left_to_right:int, top_down:int) -> int:
	return top_down * line_element + left_to_right

func set_cube_index_1d_color(index:int, color:Color):
	var coord := convert_1d_to_2d(index)
	set_cube_index_2d_color(coord.x, coord.y, color)

func set_cube_index_2d_color(left_to_right:int, top_down:int, color:Color, with_update:bool = true):
	if texture == null:
		return
	
	# Clamp indices to valid range
	left_to_right = clampi(left_to_right, 0, line_element - 1)
	top_down = clampi(top_down, 0, line_element - 1)
	
	var image := texture.get_image()

	for x in range(pixels_per_cell):
		for y in range(pixels_per_cell):
			var px = left_to_right * pixels_per_cell + x
			var py = top_down * pixels_per_cell + y
			image.set_pixel(px, py, color)

	texture.update(image)
	if with_update:
		on_texture_updated.emit(texture)



func update_the_image_and_emit():
	if texture == null:
		return
	var image := texture.get_image()
	texture.update(image)
	on_texture_updated.emit(texture)

func set_cube_index_1d_with_color_array(colors:Array[Color], with_update:bool = true):
	for i in range(colors.size()):
		var xy := convert_1d_to_2d(i)
		set_cube_index_2d_color(xy.x, xy.y, colors[i], false)
	if with_update:
		update_the_image_and_emit()
	
func set_cube_index_1d_with_byte_rgb_array(colors:Array[PackedByteArray]):
	var result:Array[Color] = []
	for i in range(colors.size()):
		var byte_color := colors[i]
		var r:float = byte_color[0] / 255.0
		var g:float = byte_color[1] / 255.0
		var b:float = byte_color[2] / 255.0
		var color := Color(r, g, b, 1.0)
		var xy := convert_1d_to_2d(i)
		result.append(color)
	set_cube_index_1d_with_color_array(result,true)


func set_cube_index_1d_to_on_off(index:int, is_on:bool):
	if is_on:
		set_cube_index_1d_color(index, color_for_true)
	else:
		set_cube_index_1d_color(index, color_for_false)

func _ready():
	var size:int = line_element * pixels_per_cell
	var image := Image.create(size, size, false, Image.FORMAT_RGBA8)
	var image_texture := ImageTexture.create_from_image(image)
	texture = image_texture
	material_duplicated = material_to_duplicate.duplicate(true)
	material_duplicated.albedo_texture = texture
	if use_random_at_ready:
			for i in range(512):
				var color := Color(randf(), randf(), randf(), 1.0)
				set_cube_index_1d_color(i, color)
	on_texture_material_updated.emit(0, material_duplicated)
	on_texture_updated.emit(texture)
