class_name SensorFacadeDigit16
extends Node

@export var set_segment_one_by_one:SensorSetDigit16SegmentOnOff
@export var set_segment_with_char:SensorSetDigit16SegmentWithLetter

func set_with_loaded_char(text_char:String):
	set_segment_with_char.set_digit_from_char(text_char)

func set_with_text_image(text_image:String):
	set_segment_with_char.set_digit_from_string_image_0_1(text_image)
	
func set_all_at_random():
	set_segment_one_by_one.set_all_at_random()
func set_all_on():
	set_segment_one_by_one.set_all_on()
	
func set_all_off():
	set_segment_one_by_one.set_all_off()

func set_on_off(is_on:bool):
	set_segment_one_by_one.set_all_on_off(is_on)

func set_dot(is_on:bool):
	set_segment_one_by_one.set_segment_dot(is_on)
	
func set_segment_1(is_on:bool):
	set_segment_one_by_one.set_segment_1(is_on)
func set_segment_2(is_on:bool):
	set_segment_one_by_one.set_segment_2(is_on)
func set_segment_3(is_on:bool):
	set_segment_one_by_one.set_segment_3(is_on)

func set_segment_4(is_on:bool):
	set_segment_one_by_one.set_segment_4(is_on)
func set_segment_6(is_on:bool):
	set_segment_one_by_one.set_segment_6(is_on)
func set_segment_7(is_on:bool):
	set_segment_one_by_one.set_segment_7(is_on)
func set_segment_8(is_on:bool):
	set_segment_one_by_one.set_segment_8(is_on)
func set_segment_9(is_on:bool):
	set_segment_one_by_one.set_segment_9(is_on)

func set_segment_top_left(is_on:bool):
	set_segment_one_by_one.set_segment_top_left(is_on)
	
func set_segment_top_right(is_on:bool):
	set_segment_one_by_one.set_segment_top_right(is_on)	

func set_segment_left_top(is_on:bool):
	set_segment_one_by_one.set_segment_left_top(is_on)

func set_segment_right_top(is_on:bool):
	set_segment_one_by_one.set_segment_right_top(is_on)

func set_segment_left_down(is_on:bool):
	set_segment_one_by_one.set_segment_left_down(is_on)

func set_segment_right_down(is_on:bool):
	set_segment_one_by_one.set_segment_right_down(is_on)

func set_segment_down_left(is_on:bool):
	set_segment_one_by_one.set_segment_down_left(is_on)

func set_segment_down_right(is_on:bool):
	set_segment_one_by_one.set_segment_down_right(is_on)
	
func clear_and_load_char_images_from_text(text_image:String):
	set_segment_with_char.clear_and_load_char_images_from_text(text_image)
