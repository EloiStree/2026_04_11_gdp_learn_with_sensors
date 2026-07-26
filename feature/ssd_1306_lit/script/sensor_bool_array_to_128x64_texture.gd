@tool
class_name SensorBoolArrayTo128x64Texture
extends Node3D

signal on_texture_material_updated(index:int, material_surface:Material)
signal on_texture_updated(texture: Texture2D)

@export var _color_on: Color = Color(0.0, 0.0, 0.0, 1.0)  
@export var _color_off: Color = Color(0.898, 0.504, 0.0, 1.0)

const SCREEN_WIDTH: int = 128
const SCREEN_HEIGHT: int = 64
const SCREEN_SIZE: int = SCREEN_WIDTH * SCREEN_HEIGHT
const SCREEN_SIZE_INDEX_MAX: int = SCREEN_SIZE - 1

var _texture_2d: Texture2D



@export var _use_mipmaps: bool = false
@export var _material_to_duplicate: StandardMaterial3D

var _bool_array_clear: Array[bool] = []
var _bool_array_full: Array[bool] = []

@export var _color_style: ColorStyle:
	set (value):
		_color_style =value

@export var _random_value_at_start:bool=true

@export_group("Debug")
@export var _material_duplicated: StandardMaterial3D

enum ColorStyle {
	INSEPCTOR_VALUE,
	OLED_BLACK_BLUE,
	OLED_BLACK_GREEN,
	OLED_BLACK_WHITE_BLUE,
	E_INK,
	BLACK_TRUE_ON_WHITE_FALSE,
	WHITE_TRUE_ON_BLACK_FALSE,
	GAMEBOY_DARK,
	GAMEBOY_LIGHT,
	FLIPPER_ORANGE,
}

func set_color_style_as_sh1106_oled_blue_screen():
	# OLED blue: #007BFF
	_color_on = Color("a2e5ffff")  # OLED blue
	_color_off = Color("#000000")  # background
	set_texture_with_boolean_array(_bool_array_clear)

func set_color_style_as_oled_green_screen():
	# OLED green: #00bf29
	_color_on = Color("00fa39ff")   # OLED green
	_color_off = Color("#000000")  # background
	set_texture_with_boolean_array(_bool_array_clear)


func set_color_style_as_black_true_on_white_false():
	# black true on white false
	_color_on = Color("#000000")  # black
	_color_off = Color("#FFFFFF")  # white
	set_texture_with_boolean_array(_bool_array_clear)

func set_color_style_as_white_true_on_black_false():
	# white true on black false
	_color_on = Color("#FFFFFF")  # white
	_color_off = Color("#000000")  # black
	set_texture_with_boolean_array(_bool_array_clear)

func set_color_style_as_black_green_matrix():
	# white true on black false
	_color_on = Color("00ff41")  # white
	_color_off = Color("#000000")  # black
	set_texture_with_boolean_array(_bool_array_clear)

func set_color_style_as_e_ink_screen():
	# E-ink style: white for "on" pixels, light gray for "off" pixels
	# white
	_color_off = Color("#FFFFFF")  # white	
	# BLACK DARK GRAY #5A5A5A
	_color_on = Color("#5A5A5A")  # dark gray
	set_texture_with_boolean_array(_bool_array_clear)  


func set_color_style_as_gameboy_on_dark():
	# Screen tint (unlit LCD greenish): #9BBC0F
	# Screen dark green (active pixels): #0F380F
	_color_on = Color("#0F380F")  # dark green
	_color_off = Color("#9BBC0F")  # light green

func set_color_style_as_flipper_orange():
	_color_on = Color("232323ff")  # dark green
	_color_off = Color("ff8833ff")  # light green
	

func set_color_style_as_gameboy_on_light():
	# Screen tint (unlit LCD greenish): #9BBC0F
	# Screen dark green (active pixels): #0F380F
	_color_off = Color("#0F380F")  # dark green
	_color_on = Color("#9BBC0F")  # light green

	set_texture_with_boolean_array(_bool_array_clear)  


func set_color_style_as_ssd1306_black_white_blue():
	_color_off = Color("000000ff") 
	_color_on = Color("dfe8e1ff")  

	set_texture_with_boolean_array(_bool_array_clear)  

var is_init=false
func _ready() -> void:
	if is_init==false:
		_setup_the_texture_check()
	if _random_value_at_start:
		var array: Array[bool] = []
		array.resize(SCREEN_SIZE)
		for i in range(SCREEN_SIZE):
			array[i] = randf() < 0.5
		#print("Yo ", array)
		set_texture_with_boolean_array(array)
		
		


func _setup_the_texture_check():
	if is_init:
		return
	is_init=true
	print("dd")

	_bool_array_clear.resize(SCREEN_SIZE)
	_bool_array_full.resize(SCREEN_SIZE)
	for i in range(SCREEN_SIZE):
		_bool_array_clear[i] = false
		_bool_array_full[i] = true

	_material_duplicated = _material_to_duplicate.duplicate() as StandardMaterial3D
	var image = Image.create(SCREEN_WIDTH, SCREEN_HEIGHT, false, Image.FORMAT_RGB8)
	_texture_2d = ImageTexture.create_from_image(image)
	_material_duplicated.albedo_texture = _texture_2d

	
	set_texture_with_boolean_array(_bool_array_clear)
	
	
	if _color_style == ColorStyle.E_INK:
		set_color_style_as_e_ink_screen()
	elif _color_style == ColorStyle.GAMEBOY_DARK:
		set_color_style_as_gameboy_on_dark()
	elif _color_style == ColorStyle.GAMEBOY_LIGHT:
		set_color_style_as_gameboy_on_light()
	elif _color_style == ColorStyle.OLED_BLACK_GREEN:
		set_color_style_as_oled_green_screen()
	elif _color_style == ColorStyle.OLED_BLACK_BLUE:
		set_color_style_as_sh1106_oled_blue_screen()
	elif _color_style == ColorStyle.BLACK_TRUE_ON_WHITE_FALSE:
		set_color_style_as_black_true_on_white_false()
	elif _color_style == ColorStyle.WHITE_TRUE_ON_BLACK_FALSE:
		set_color_style_as_white_true_on_black_false()
	elif _color_style == ColorStyle.OLED_BLACK_WHITE_BLUE:
		set_color_style_as_ssd1306_black_white_blue()
	elif _color_style == ColorStyle.FLIPPER_ORANGE:
		set_color_style_as_flipper_orange()
	print("TEST")


func inverse_color_true_false():
	_setup_the_texture_check()
	var tmp :Color= _color_on
	_color_on = _color_off
	_color_off = tmp

func set_boolean_array_to_full():
	_setup_the_texture_check()
	for i in range(SCREEN_SIZE):
		_bool_array_full[i] = true

func set_boolean_array_to_clear():
	_setup_the_texture_check()
	for i in range(SCREEN_SIZE):
		_bool_array_clear[i] = false

func get_on_off_color(is_on: bool) -> Color:
	return _color_on if is_on else _color_off

func set_color_on_off(new_true_color:Color,new_false_color:Color):
		_color_on =new_true_color
		_color_off =new_false_color
		
func set_color_on(new_true_color:Color):
	_color_on =new_true_color
	
func set_color_off(new_false_color:Color):
	_color_off =new_false_color
	
func set_texture_with_boolean_array(display_as_boolean_array: Array[bool]):
	
	if display_as_boolean_array==null:
		return 
	if display_as_boolean_array.size()<SCREEN_SIZE:
		return 
	_setup_the_texture_check()
	var image = Image.create(SCREEN_WIDTH, SCREEN_HEIGHT, false, Image.FORMAT_RGB8)
	for i in range(SCREEN_SIZE):
		var pos := index_to_xy(i)
		var is_on: bool = display_as_boolean_array[i]
		var color = get_on_off_color(is_on)
		image.set_pixel(pos.x, pos.y, color)
	_texture_2d = ImageTexture.create_from_image(image)
	_material_duplicated.albedo_texture = _texture_2d
	on_texture_updated.emit(_texture_2d)
	on_texture_material_updated.emit(0, _material_duplicated)
	print("Test ")

func set_texture_with_bit_array_if_exact_size(bit_pack_as_bytes:PackedByteArray):	
	if bit_pack_as_bytes.size()==1024:
		set_texture_with_bit_array(bit_pack_as_bytes)

func set_texture_with_text01_if_exact_size(bit_pack_as_text01: String) -> void:
	bit_pack_as_text01 = bit_pack_as_text01.replace("\r", "").replace("\n", "")
	if bit_pack_as_text01.length() != 128 * 64:
		return
	var byte_count := bit_pack_as_text01.length() / 8
	var pack := PackedByteArray()
	pack.resize(byte_count)
	for i in range(byte_count):
		var value := 0
		for j in range(8):
			var bit_index := i * 8 + j
			if bit_pack_as_text01[bit_index] == "1":
				value |= 1 << (7 - j) 
		pack[i] = value
	set_texture_with_bit_array(pack)
			
			
	
	
func set_texture_with_bit_array(bit_pack_as_bytes:PackedByteArray):
	_setup_the_texture_check()
	# expects width * height bits, packed as bytes (8 bits per byte)
	var total_bits = bit_pack_as_bytes.size() * 8
	var max_size = min(total_bits, SCREEN_SIZE)
	var result_array: Array[bool] = []
	
	for i in range(max_size):
		var byte_index = i / 8
		var bit_index = i % 8
		var is_on: bool = (bit_pack_as_bytes[byte_index] & (1 << bit_index)) != 0
		result_array.append(is_on)
	
	set_texture_with_boolean_array(result_array)
		
func index_to_xy(index: int) -> Vector2i:
	var x: int = index % SCREEN_WIDTH
	var y: int = index / SCREEN_WIDTH
	return Vector2i(x, y)

func xy_to_index(x: int, y: int) -> int:
	return y * SCREEN_WIDTH + x
