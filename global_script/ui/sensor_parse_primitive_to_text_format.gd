class_name SensorParsePrimitiveToTextFormat
extends Node


signal on_parse_as_text(value:String)


@export var float_format: String = "%.2f"

func parse_float_to_text(value: float):
	var formatted_value := float_format % value
	on_parse_as_text.emit(formatted_value)
	
	
func parse_integer_to_text(value:int):
	on_parse_as_text.emit(str(value))
	
func parse_vector3_to_text(value:Vector3):
	var xstring := float_format.format(value.x)
	var ystring := float_format.format(value.y)
	var zstring := float_format.format(value.z)
	on_parse_as_text.emit("(%s, %s, %s)" % [xstring, ystring, zstring])

func parse_string_to_text(value:String):
	on_parse_as_text.emit(value)

func parse_char_array_to_text(value:Array[String]):
	on_parse_as_text.emit(str(value))


func parse_string_to_clamp_text_by_size(value:String, max_length:int, ending_omission:String = "..."):
	if value.length() > max_length:
		value = value.substr(0, max_length) + ending_omission
	on_parse_as_text.emit(value)


func parse_bool_to_text(value:bool):
	on_parse_as_text.emit(str(value))	

func parse_bool_to_yes_no_text(value:bool):
	on_parse_as_text.emit("Yes" if value else "No")

func parse_bool_to_0_1_text(value:bool):
	on_parse_as_text.emit("1" if value else "0")

func parse_bool_to_on_off_text(value:bool):
	on_parse_as_text.emit("On" if value else "Off")

	
func parse_bool_array_to_0_1_text(value:Array[bool]):
	# TODO: VERIFY
	var result := []
	for b in value:
		result.append("1" if b else "0")
	on_parse_as_text.emit("".join(result))
	
	
func parse_packed_string_to_text(value: PackedStringArray, separator: String = ", "):
	# TODO: VERIFY
	var result = separator.join(value)
	on_parse_as_text.emit(str(result))

func parse_packed_vector3_to_text(value: PackedVector3Array, separator: String = "; "):
	# TODO: VERIFY
	var result = []
	for v in value:
		var xstring := float_format.format(v.x)
		var ystring := float_format.format(v.y)
		var zstring := float_format.format(v.z)
		result.append("(%s, %s, %s)" % [xstring, ystring, zstring])
	on_parse_as_text.emit(separator.join(result))

func parse_packed_byte_as_bool_to_text(pack: PackedByteArray, separator: String = ""):
	# TODO: VERIFY
	var result = []
	for b in pack:
		for i in range(8):
			var bit_value :bool= (b >> i) & 1
			result.append("1" if bit_value else "0")
	on_parse_as_text.emit(separator.join(result))


func parse_node_name_to_text(node: Node):
	var name := node.name if node else "None"
	on_parse_as_text.emit(name)
	
