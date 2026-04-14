class_name SensorSetDigit8SegmentOnOff
extends Node


enum NameOfDigitSegment8 {
	SEGMENT_0,
	SEGMENT_1,
	SEGMENT_2,
	SEGMENT_3,
	SEGMENT_5,
	SEGMENT_7,
	SEGMENT_8,
	SEGMENT_9,
}

@export var segment_0:Node3D
@export var segment_1:Node3D
@export var segment_2:Node3D
@export var segment_3:Node3D
@export var segment_5:Node3D
@export var segment_7:Node3D
@export var segment_8:Node3D
@export var segment_9:Node3D


func set_on_off_segment(is_on:bool , node:Node3D):
	if is_on:
		node.show()
	else:
		node.hide()

func set_segment_on_off_with_enum(enum_value: NameOfDigitSegment8, is_on:bool):
	match enum_value:
		NameOfDigitSegment8.SEGMENT_0: set_on_off_segment(is_on,segment_0)
		NameOfDigitSegment8.SEGMENT_1: set_on_off_segment(is_on,segment_1)
		NameOfDigitSegment8.SEGMENT_2: set_on_off_segment(is_on,segment_2)
		NameOfDigitSegment8.SEGMENT_3: set_on_off_segment(is_on,segment_3)
		NameOfDigitSegment8.SEGMENT_5: set_on_off_segment(is_on,segment_5)
		NameOfDigitSegment8.SEGMENT_7: set_on_off_segment(is_on,segment_7)
		NameOfDigitSegment8.SEGMENT_8: set_on_off_segment(is_on,segment_8)
		NameOfDigitSegment8.SEGMENT_9: set_on_off_segment(is_on,segment_9)

func set_segment_on_off_with_match_string(value_untyped:String, is_on:bool):
	value_untyped = value_untyped.strip_edges().to_upper()
	match value_untyped:

		["0","DOT"]: set_on_off_segment(is_on,segment_0)
		["1","DL"]: set_on_off_segment(is_on,segment_1)
		["2","D"]: set_on_off_segment(is_on,segment_2)
		["3","DR"]: set_on_off_segment(is_on,segment_3)
		["5","C"]: set_on_off_segment(is_on,segment_5)
		["7","TL"]: set_on_off_segment(is_on,segment_7)
		["8","T"]: set_on_off_segment(is_on,segment_8)
		["9","TR"]: set_on_off_segment(is_on,segment_9)

var segment_array:Array[Node3D] = []

func _ready():
		segment_array = []
		segment_array.append(segment_0)
		segment_array.append(segment_1)
		segment_array.append(segment_2)
		segment_array.append(segment_3)
		segment_array.append(segment_5)
		segment_array.append(segment_7)
		segment_array.append(segment_8)
		segment_array.append(segment_9)

func set_all_off():
	for segment in segment_array:
		set_on_off_segment(false,segment)

func set_all_on():
	for segment in segment_array:
		set_on_off_segment(true,segment)


func set_all_on_off(is_on:bool):
	if is_on:
		set_all_on()
	else:
		set_all_off()

func set_all_at_random():
	for segment in segment_array:
		var is_on = randi() % 2 == 0
		set_on_off_segment(is_on,segment)



func set_segment_0(is_on:bool):
	set_on_off_segment(is_on,segment_0)

func set_segment_1(is_on:bool):
	set_on_off_segment(is_on,segment_1)

func set_segment_2(is_on:bool):
	set_on_off_segment(is_on,segment_2)

func set_segment_3(is_on:bool):
	set_on_off_segment(is_on,segment_3)

func set_segment_5(is_on:bool):
	set_on_off_segment(is_on,segment_5)

func set_segment_7(is_on:bool):
	set_on_off_segment(is_on,segment_7)

func set_segment_8(is_on:bool):
	set_on_off_segment(is_on,segment_8)

func set_segment_9(is_on:bool):
	set_on_off_segment(is_on,segment_9)

func set_segment_dot(is_on:bool):
	set_on_off_segment(is_on,segment_0)
