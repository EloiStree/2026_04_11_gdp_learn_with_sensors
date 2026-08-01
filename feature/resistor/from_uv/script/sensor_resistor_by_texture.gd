class_name SensorResistorByTexture
extends Node

signal on_texture_updated(texture: Texture2D)
signal on_texture_updated_in_material(material_index: int, material: Material)

@export var use_mipmaps: bool = false
@export var default_color: Color = Color.BLACK
@export var material_to_wrap_texture: StandardMaterial3D
@export var random_line_at_ready: bool = true

@export var body_color: Color = Color(0.995, 0.658, 0.375, 1.0)
@export var cable_color: Color = Color(0.662, 0.721, 0.692, 1.0)

var _image: Image
var _image_texture: ImageTexture

# 8 lines * 4 pixels each = 32 width (this was your crash)
const TEXTURE_SIZE := Vector2i(32, 32)
const LINE_LENGTH: int = 4
const LINE_COUNT: int = 8

# -------------------------------------------------
# COLORS
# -------------------------------------------------

const COLOR_BLACK_0: Color = Color(0.0, 0.0, 0.0)
const COLOR_BROWN_1: Color = Color(0.4, 0.2, 0.0)
const COLOR_RED_2: Color = Color(0.8, 0.0, 0.0)
const COLOR_ORANGE_3: Color = Color(1.0, 0.5, 0.0)
const COLOR_YELLOW_4: Color = Color(1.0, 1.0, 0.0)
const COLOR_GREEN_5: Color = Color(0.0, 0.6, 0.0)
const COLOR_BLUE_6: Color = Color(0.0, 0.3, 1.0)
const COLOR_VIOLET_7: Color = Color(0.6, 0.0, 0.8)
const COLOR_GRAY_8: Color = Color(0.5, 0.5, 0.5)
const COLOR_WHITE_9: Color = Color(1.0, 1.0, 1.0)

const COLOR_GOLD: Color = Color(1.0, 0.84, 0.0)
const COLOR_SILVER: Color = Color(0.75, 0.75, 0.75)

# -------------------------------------------------
# READY
# -------------------------------------------------

func _ready() -> void:
	_create_texture()

	if random_line_at_ready:
		set_random_lines()

	set_body_color(body_color)
	set_cable_color(cable_color)

	notify_changed()
# -------------------------------------------------
# RANDOMIZATION
# -------------------------------------------------

func set_random_lines():
	set_line_0_color_index_0_9(randi_range(-1, 9))
	set_line_1_color_index_0_9(randi_range(-1, 9))
	set_line_2_color_index_0_9(randi_range(-1, 9))
	set_line_3_color_index_0_9(randi_range(-1, 9))
	set_line_4_color_index_0_9(randi_range(-1, 6))
	set_line_5_color_index_0_9(randi_range(1, 2))
	notify_changed()

# -------------------------------------------------
# COLOR HELPERS
# -------------------------------------------------

func get_color_from_index_0_9(index: int) -> Color:
	match index:
		-1: return body_color
		0: return COLOR_BLACK_0
		1: return COLOR_BROWN_1
		2: return COLOR_RED_2
		3: return COLOR_ORANGE_3
		4: return COLOR_YELLOW_4
		5: return COLOR_GREEN_5
		6: return COLOR_BLUE_6
		7: return COLOR_VIOLET_7
		8: return COLOR_GRAY_8
		9: return COLOR_WHITE_9
		_:
			push_error("Invalid color index (0-9 expected)")
			return default_color

# -------------------------------------------------
# INDEX SETTERS
# -------------------------------------------------

func set_line_0_color_index_0_9(i: int): set_line_0_color(get_color_from_index_0_9(i))
func set_line_1_color_index_0_9(i: int): set_line_1_color(get_color_from_index_0_9(i))
func set_line_2_color_index_0_9(i: int): set_line_2_color(get_color_from_index_0_9(i))
func set_line_3_color_index_0_9(i: int): set_line_3_color(get_color_from_index_0_9(i))
func set_line_4_color_index_0_9(i: int): set_line_4_color(get_color_from_index_0_9(i))
func set_line_5_color_index_0_9(i: int): set_line_5_color(get_color_from_index_0_9(i))

func set_body_color_from_index_0_9(i: int):
	set_body_color(get_color_from_index_0_9(i))

# -------------------------------------------------
# SPECIAL COLORS
# -------------------------------------------------

func set_line_5_color_gold():
	set_line_5_color(COLOR_GOLD)

func set_line_5_color_silver():
	set_line_5_color(COLOR_SILVER)

func set_body_color_gold():
	set_body_color(COLOR_GOLD)

func set_body_color_silver():
	set_body_color(COLOR_SILVER)

# -------------------------------------------------
# LINE SETTERS
# -------------------------------------------------

func set_line_0_color(color: Color) -> void: set_line_index(0, color)
func set_line_1_color(color: Color) -> void: set_line_index(1, color)
func set_line_2_color(color: Color) -> void: set_line_index(2, color)
func set_line_3_color(color: Color) -> void: set_line_index(3, color)
func set_line_4_color(color: Color) -> void: set_line_index(4, color)
func set_line_5_color(color: Color) -> void: set_line_index(5, color)

func set_body_color(color: Color) -> void: set_line_index(6, color)
func set_cable_color(color: Color) -> void: set_line_index(7, color)

func notify_changed():
	on_texture_updated.emit(_image_texture)
	on_texture_updated_in_material.emit(0,material_to_wrap_texture)
	


func hide_line_by_index_0_5(index_0_5:int):
	match index_0_5:
		0 : set_line_0_color(body_color)
		1 : set_line_0_color(body_color)
		2 : set_line_0_color(body_color)
		3 : set_line_0_color(body_color)
		4 : set_line_0_color(body_color)
		5 : set_line_0_color(body_color)
		
func set_line_index(index: int, color: Color) -> void:
	if index < 0 or index >= LINE_COUNT:
		push_error("Index must be between 0 and 7")
		return

	var x_start := index * LINE_LENGTH

	# sanity guard (because history shows you need one)
	if x_start + LINE_LENGTH > TEXTURE_SIZE.x:
		push_error("Texture too small for line index: " + str(index))
		return

	for y in range(TEXTURE_SIZE.y):
		for x in range(LINE_LENGTH):
			_image.set_pixel(x_start + x, y, color)

	_apply_texture_update()


func set_all_lines(colors: Array[Color]) -> void:
	var count := mini(colors.size(), LINE_COUNT)

	for i in range(count):
		var x_start := i * LINE_LENGTH
		for y in range(TEXTURE_SIZE.y):
			for x in range(LINE_LENGTH):
				_image.set_pixel(x_start + x, y, colors[i])

	_apply_texture_update()

# -------------------------------------------------
# TEXTURE MANAGEMENT
# -------------------------------------------------

func _create_texture() -> void:
	_image = Image.create(
		TEXTURE_SIZE.x,
		TEXTURE_SIZE.y,
		use_mipmaps,
		Image.FORMAT_RGBA8
	)

	_image.fill(default_color)

	_image_texture = ImageTexture.create_from_image(_image)

	if material_to_wrap_texture:
		material_to_wrap_texture.albedo_texture = _image_texture


func _apply_texture_update() -> void:
	if _image_texture:
		_image_texture.update(_image)
	else:
		_image_texture = ImageTexture.create_from_image(_image)

	if material_to_wrap_texture:
		material_to_wrap_texture.albedo_texture = _image_texture

	notify_changed()


func get_image_texture() -> Texture2D:
	return _image_texture
