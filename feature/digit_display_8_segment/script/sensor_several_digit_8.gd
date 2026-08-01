class_name SensorSeveralDigit8
extends Node


@export var digit8_left_right:Array[SensorFacadeDigit8]
	


func get_digit_facade_by_index_left_to_right(index_0_to_size:int)->SensorFacadeDigit8:
	if index_0_to_size>=0 and index_0_to_size<digit8_left_right.size():
		return digit8_left_right[index_0_to_size]
	return null

func get_digit_facade_by_index_right_to_left(index_0_to_size:int)->SensorFacadeDigit8:
	var size = digit8_left_right.size()
	if index_0_to_size>=0 and index_0_to_size<size:
		return digit8_left_right[size-1-index_0_to_size]
	return null


func turn_all_digits_off():
	for digit in digit8_left_right:
		digit.set_all_off()

func turn_all_digits_on():
	for digit in digit8_left_right:
		digit.set_all_on()

func turn_all_digits_on_off(is_on:bool):
	for digit in digit8_left_right:
		digit.set_on_off(is_on)

func set_all_digits_at_random():
	for digit in digit8_left_right:
		digit.set_all_at_random()

func set_digit_text(text:String):
	var text_length = text.length()
	var count = digit8_left_right.size()
	var index = 0
	turn_all_digits_off()
	for c in text:
		if index>=count:
			break
		var digit = digit8_left_right[index]
		digit.set_with_loaded_char(c)
		index+=1

func clear_and_load_char_images_from_text(text_to_load:String):
	for digit in digit8_left_right:
		digit.clear_and_load_char_images_from_text(text_to_load)


	
