class_name SensorSetDigit16SegmentOnOff
extends Node


enum NameOfDigitSegment16 {
	SEGMENT_0,
	SEGMENT_1,
	SEGMENT_2,
	SEGMENT_3,
	SEGMENT_4,
	SEGMENT_6,
	SEGMENT_7,
	SEGMENT_8,
	SEGMENT_9,
	SEGMENT_TL,
	SEGMENT_TR,
	SEGMENT_RT,
	SEGMENT_RD,
	SEGMENT_DR,
	SEGMENT_DL,
	SEGMENT_LD,
	SEGMENT_LT
}

@export var segment_0:Node3D
@export var segment_1:Node3D
@export var segment_2:Node3D
@export var segment_3:Node3D
@export var segment_4:Node3D
@export var segment_6:Node3D
@export var segment_7:Node3D
@export var segment_8:Node3D
@export var segment_9:Node3D
@export var segment_TL:Node3D
@export var segment_TR:Node3D
@export var segment_RT:Node3D
@export var segment_RD:Node3D
@export var segment_DR:Node3D
@export var segment_DL:Node3D
@export var segment_LD:Node3D
@export var segment_LT:Node3D


func set_on_off_segment(is_on:bool , node:Node3D):
	if is_on:
		node.show()
	else:
		node.hide()

func set_segment_on_off_with_enum(enum_value: NameOfDigitSegment16, is_on:bool):
	match enum_value:
		NameOfDigitSegment16.SEGMENT_0: set_on_off_segment(is_on,segment_0)
		NameOfDigitSegment16.SEGMENT_1: set_on_off_segment(is_on,segment_1)
		NameOfDigitSegment16.SEGMENT_2: set_on_off_segment(is_on,segment_2)
		NameOfDigitSegment16.SEGMENT_3: set_on_off_segment(is_on,segment_3)
		NameOfDigitSegment16.SEGMENT_4: set_on_off_segment(is_on,segment_4)
		NameOfDigitSegment16.SEGMENT_6: set_on_off_segment(is_on,segment_6)
		NameOfDigitSegment16.SEGMENT_7: set_on_off_segment(is_on,segment_7)
		NameOfDigitSegment16.SEGMENT_8: set_on_off_segment(is_on,segment_8)
		NameOfDigitSegment16.SEGMENT_9: set_on_off_segment(is_on,segment_9)
		NameOfDigitSegment16.SEGMENT_TL: set_on_off_segment(is_on,segment_TL)
		NameOfDigitSegment16.SEGMENT_TR: set_on_off_segment(is_on,segment_TR)
		NameOfDigitSegment16.SEGMENT_RT: set_on_off_segment(is_on,segment_RT)
		NameOfDigitSegment16.SEGMENT_RD: set_on_off_segment(is_on,segment_RD)
		NameOfDigitSegment16.SEGMENT_DR: set_on_off_segment(is_on,segment_DR)
		NameOfDigitSegment16.SEGMENT_DL: set_on_off_segment(is_on,segment_DL)
		NameOfDigitSegment16.SEGMENT_LD: set_on_off_segment(is_on,segment_LD)
		NameOfDigitSegment16.SEGMENT_LT: set_on_off_segment(is_on,segment_LT)

func set_segment_on_off_with_match_string(value_untyped:String, is_on:bool):
	value_untyped = value_untyped.strip_edges().to_upper()
	match value_untyped:

		["0","DOT"]: set_on_off_segment(is_on,segment_0)
		["1","SE"]: set_on_off_segment(is_on,segment_1)
		["2","S"]: set_on_off_segment(is_on,segment_2)
		["3","SW","SO"]: set_on_off_segment(is_on,segment_3)
		["4","E"]: set_on_off_segment(is_on,segment_4)
		["6","W","O"]: set_on_off_segment(is_on,segment_6)
		["7","NE"]: set_on_off_segment(is_on,segment_7)
		["8","N"]: set_on_off_segment(is_on,segment_8)
		["9","NW","NO"]: set_on_off_segment(is_on,segment_9)
		["TL"]: set_on_off_segment(is_on,segment_TL)
		["TR"]: set_on_off_segment(is_on,segment_TR)
		["RT"]: set_on_off_segment(is_on,segment_RT)
		["RD"]: set_on_off_segment(is_on,segment_RD)
		["DR"]: set_on_off_segment(is_on,segment_DR)
		["DL"]: set_on_off_segment(is_on,segment_DL)
		["LD"]: set_on_off_segment(is_on,segment_LD)
		["LT"]: set_on_off_segment(is_on,segment_LT)

var segment_array:Array[Node3D] = []

func _ready():
		segment_array = []
		segment_array.append(segment_0)
		segment_array.append(segment_1)
		segment_array.append(segment_2)
		segment_array.append(segment_3)
		segment_array.append(segment_4)
		segment_array.append(segment_6)
		segment_array.append(segment_7)
		segment_array.append(segment_8)
		segment_array.append(segment_9)
		segment_array.append(segment_TL)
		segment_array.append(segment_TR)
		segment_array.append(segment_RT)	
		segment_array.append(segment_RD)
		segment_array.append(segment_DR)
		segment_array.append(segment_DL)
		segment_array.append(segment_LD)
		segment_array.append(segment_LT)


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

func set_segment_4(is_on:bool):
	set_on_off_segment(is_on,segment_4)


func set_segment_6(is_on:bool):
	set_on_off_segment(is_on,segment_6)

func set_segment_7(is_on:bool):
	set_on_off_segment(is_on,segment_7)

func set_segment_8(is_on:bool):
	set_on_off_segment(is_on,segment_8)

func set_segment_9(is_on:bool):
	set_on_off_segment(is_on,segment_9)

func set_segment_top_left(is_on:bool):
	set_on_off_segment(is_on,segment_TL)
	
func set_segment_top_right(is_on:bool):
	set_on_off_segment(is_on,segment_TR)

func set_segment_right_top(is_on:bool):
	set_on_off_segment(is_on,segment_RT)	

func set_segment_right_down(is_on:bool):
	set_on_off_segment(is_on,segment_RD)

func set_segment_down_right(is_on:bool):
	set_on_off_segment(is_on,segment_DR)	

func set_segment_down_left(is_on:bool):
	set_on_off_segment(is_on,segment_DL)

func set_segment_left_down(is_on:bool):
	set_on_off_segment(is_on,segment_LD)

func set_segment_left_top(is_on:bool):
	set_on_off_segment(is_on,segment_LT)


func set_segment_dot(is_on:bool):
	set_on_off_segment(is_on,segment_0)
