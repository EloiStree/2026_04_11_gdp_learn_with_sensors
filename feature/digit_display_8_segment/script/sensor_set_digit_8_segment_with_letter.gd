class_name  SensorSetDigit8SegmentWithLetter
extends Node


@export var digit8:SensorSetDigit8SegmentOnOff



func set_digit_from_char(char:String):
	if char in char_to_image:
		var text_image = char_to_image[char]
		set_digit_from_string_image_0_1(text_image)
	elif char=="RANDOM":
		digit8.set_all_at_random()
	else:		
		digit8.set_all_off()

func clear_digit_off():
	digit8.set_all_off()

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
	if text_as_line.length()<15:
		return 
	digit8.set_segment_7(text_as_line[3]==IS_TRUE)
	digit8.set_segment_8(text_as_line[1]==IS_TRUE)
	digit8.set_segment_9(text_as_line[5]==IS_TRUE)
	digit8.set_segment_5(text_as_line[7]==IS_TRUE)
	digit8.set_segment_1(text_as_line[9]==IS_TRUE)
	digit8.set_segment_2(text_as_line[13]==IS_TRUE)
	digit8.set_segment_3(text_as_line[11]==IS_TRUE)
	digit8.set_segment_dot(text_as_line[14]==IS_TRUE)
	
func append_digit_from_string_image_0_1(text_image:String):
	var text_as_line = remove_all_except_1_0(text_image)
	if text_as_line.length()<15:
		return 

	if text_as_line[3]==IS_TRUE:
		digit8.set_segment_7(true)
	if text_as_line[1]==IS_TRUE:
		digit8.set_segment_8(true)
	if text_as_line[5]==IS_TRUE:
		digit8.set_segment_9(true)
	if text_as_line[7]==IS_TRUE:
		digit8.set_segment_5(true)
	if text_as_line[9]==IS_TRUE:
		digit8.set_segment_1(true)
	if text_as_line[13]==IS_TRUE:
		digit8.set_segment_2(true)
	if text_as_line[11]==IS_TRUE:
		digit8.set_segment_3(true)
	if text_as_line[14]==IS_TRUE:
		digit8.set_segment_dot(true)
		

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
# 010
# 101
# 010
# 101
# 011
# """,

}

	
const IMAGE_OFF:String="""
000
000
000
000
000
"""

const IMAGE_ON:String="""
010
101
010
101
011
"""
const IMAGE_BORDER:String="""
010
101
000
101
011
"""

const IMAGE_DOT:String="""
000
000
000
000
001
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
