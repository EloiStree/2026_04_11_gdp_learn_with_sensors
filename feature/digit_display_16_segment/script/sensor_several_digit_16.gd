class_name SensorSeveralDigit16
extends Node


@export var digit16_left_right:Array[SensorFacadeDigit16]



func get_digit_facade_by_index_left_to_right(index_0_to_size:int)->SensorFacadeDigit16:
	if index_0_to_size>=0 and index_0_to_size<digit16_left_right.size():
		return digit16_left_right[index_0_to_size]
	return null

func get_digit_facade_by_index_right_to_left(index_0_to_size:int)->SensorFacadeDigit16:
	var size = digit16_left_right.size()
	if index_0_to_size>=0 and index_0_to_size<size:
		return digit16_left_right[size-1-index_0_to_size]
	return null


func turn_all_digits_off():
	for digit in digit16_left_right:
		digit.set_all_off()

func turn_all_digits_on():
	for digit in digit16_left_right:
		digit.set_all_on()

func turn_all_digits_on_off(is_on:bool):
	for digit in digit16_left_right:
		digit.set_on_off(is_on)

func set_all_digits_at_random():
	for digit in digit16_left_right:
		digit.set_all_at_random()

func set_digit_text(text:String):
	var text_length = text.length()
	var count = digit16_left_right.size()
	var index = 0
	turn_all_digits_off()
	for c in text:
		if index>=count:
			break
		var digit = digit16_left_right[index]
		digit.set_with_loaded_char(c)
		index+=1

func clear_and_load_char_images_from_text(text_to_load:String):
	for digit in digit16_left_right:
		digit.clear_and_load_char_images_from_text(text_to_load)


	
# Not that we are not trying to designa  display that know what it display.
# not reading here just obeying. The reading and knowing part should be in the other developer code.

#if you pout the model (data) in the view. Your class can become complexe very fast.
