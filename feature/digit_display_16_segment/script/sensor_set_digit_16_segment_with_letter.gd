class_name  SensorSetDigit16SegmentWithLetter
extends Node


@export var digit16:SensorSetDigit16SegmentOnOff



func set_digit_from_char(char:String):
	if char in char_to_image:
		var text_image = char_to_image[char]
		set_digit_from_string_image_0_1(text_image)
	elif char=="RANDOM":
		digit16.set_all_at_random()
	else:		
		digit16.set_all_off()

func clear_digit_off():
	digit16.set_all_off()

func append_digit_from_char(char:String):
	if char in char_to_image:
		var text_image = char_to_image[char]
		append_digit_from_string_image_0_1(text_image)

func remove_all_except_1_0(text:String)->String:
	var result :=""
	for c in text:
		if c=="1":
			result+="1"
		elif c=="0":
			result+="0"
	return result

const IS_TRUE :="1"
func set_digit_from_string_image_0_1(text_image:String):
	var text_as_line = remove_all_except_1_0(text_image)
	if text_as_line.length()<25:
		return 
	digit16.set_segment_top_left(text_as_line[1]==IS_TRUE)
	digit16.set_segment_top_right(text_as_line[3]==IS_TRUE)
	
	digit16.set_segment_left_top(text_as_line[5]==IS_TRUE)
	digit16.set_segment_7(text_as_line[6]==IS_TRUE)
	digit16.set_segment_8(text_as_line[7]==IS_TRUE)
	digit16.set_segment_9(text_as_line[8]==IS_TRUE)
	digit16.set_segment_right_top(text_as_line[9]==IS_TRUE)
	
	digit16.set_segment_4(text_as_line[11]==IS_TRUE)
	digit16.set_segment_6(text_as_line[13]==IS_TRUE)
	
	digit16.set_segment_left_down(text_as_line[15]==IS_TRUE)
	digit16.set_segment_1(text_as_line[16]==IS_TRUE)
	digit16.set_segment_2(text_as_line[17]==IS_TRUE)
	digit16.set_segment_3(text_as_line[18]==IS_TRUE)
	digit16.set_segment_right_down(text_as_line[19]==IS_TRUE)
	
	digit16.set_segment_down_left(text_as_line[21]==IS_TRUE)
	digit16.set_segment_down_right(text_as_line[23]==IS_TRUE)
	digit16.set_segment_dot(text_as_line[24]==IS_TRUE)
	
func append_digit_from_string_image_0_1(text_image:String):
	var text_as_line = remove_all_except_1_0(text_image)
	if text_as_line.length()<25:
		return 
	if text_as_line[1]==IS_TRUE:
		digit16.set_segment_top_left(true)
	if text_as_line[3]==IS_TRUE:
		digit16.set_segment_top_right(true)
	if text_as_line[5]==IS_TRUE:
		digit16.set_segment_left_top(true)
	if text_as_line[6]==IS_TRUE:
		digit16.set_segment_7(true)
	if text_as_line[7]==IS_TRUE:
		digit16.set_segment_8(true)
	if text_as_line[8]==IS_TRUE:
		digit16.set_segment_9(true)
	if text_as_line[9]==IS_TRUE:
		digit16.set_segment_left_right(true)
	if text_as_line[11]==IS_TRUE:
		digit16.set_segment_4(true)
	if text_as_line[13]==IS_TRUE:
		digit16.set_segment_6(true)
	if text_as_line[15]==IS_TRUE:
		digit16.set_segment_left_down(true)
	if text_as_line[16]==IS_TRUE:
		digit16.set_segment_1(true)
	if text_as_line[17]==IS_TRUE:
		digit16.set_segment_2(true)
	if text_as_line[18]==IS_TRUE:
		digit16.set_segment_3(true)
	if text_as_line[19]==IS_TRUE:
		digit16.set_segment_right_down(true)
	if text_as_line[21]==IS_TRUE:
		digit16.set_segment_down_left(true)
	if text_as_line[23]==IS_TRUE:
		digit16.set_segment_down_right(true)
	if text_as_line[24]==IS_TRUE:
		digit16.set_segment_dot(true)
	


func add_or_overwrite_char_image(char:String,image:String):
	char_to_image[char]=image


func _ready() -> void:
	clear_char_image_dictionary()
	add_or_overwrite_char_image(" ",IMAGE_OFF)
	load_char_to_images_from_text(read_text_from_resource_file_(text_image_load_at_ready))


func read_text_from_resource_file_(resource_path:String)->String:
	print ("Trying to read from resource file: ",resource_path)

	var abstract_path = ProjectSettings.globalize_path(resource_path)
	print("I am there: ",abstract_path)

	return read_text_file(abstract_path)


func read_text_file(path: String) -> String:
	if path.is_empty():
		push_error("Path is empty")
		return ""
	
	if not FileAccess.file_exists(path):
		push_error("File does not exist: " + path)
		return ""
	
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		# No need for file.close() in Godot 4
		return content
	else:
		push_error("Failed to open file: " + path +
			" (Error: " + str(FileAccess.get_open_error()) + ")")
		return ""


func clear_char_image_dictionary():
	char_to_image.clear()


@export_file("*.txt") var text_image_load_at_ready:String 


@export var char_to_image:Dictionary[String,String]={
# "0":"""
# 01010
# 10001
# 00000
# 10001
# 01010
# """,
# "0.":"""
# 01010
# 10001
# 00000
# 10001
# 01011
# """,
}

	
const IMAGE_OFF:String="""
00000
00000
00000
00000
00000
"""

const IMAGE_ON:String="""
01010
11111
01010
11111
01011
"""
const IMAGE_BORDER:String="""
01010
10001
00000
10001
0101
"""

const IMAGE_INNER:String="""
00000
01110
01010
01110
00000
"""
const IMAGE_DOT:String="""
00000
00000
00000
00000
00001
"""


func clear_and_load_char_image_from_text(text:String):
	clear_char_image_dictionary()
	add_or_overwrite_char_image(" ",IMAGE_OFF)
	load_char_to_images_from_text(text)

func load_char_to_images_from_text(text:String):
	var lines = text.split("\n")

	var previous_line_empty = true
	var current_line_empty = true
	var char_of_building_image = ""
	var building_array:Array[String]=[]
	var line_counter = 0

	for line in lines:
		line = line.strip_edges()
		previous_line_empty = current_line_empty
		current_line_empty = line==""

		# START OF A BLOCK
		if previous_line_empty and not current_line_empty:
			char_of_building_image = line
			building_array.clear()
			line_counter = 0

		# PROCESSING THE BLOCK
		elif not previous_line_empty and not current_line_empty:
			building_array.append(line)
			line_counter+=1
			
		# STOP OF A BLOCK
		elif not previous_line_empty and current_line_empty:
			add_or_overwrite_char_image(char_of_building_image,"".join(building_array))
