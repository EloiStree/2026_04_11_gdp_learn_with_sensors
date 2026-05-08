class_name SensorViewStripOfLedsRgbColor
extends Node


@export var leds:Array[SensorViewLedRgbColor] = []


@export_group("Add from childrens")
@export var parent_node_of_leds:Node


func turn_on():
	for led in leds:
		if led:
			led.turn_rgb_to_on_off_white(true)

func turn_off():
	for led in leds:
		if led:
			led.turn_rgb_to_on_off_white(false)


func turn_on_off(is_on:bool):
	if is_on:
		turn_on()
	else:
		turn_off()
		
func set_with_random_color():
	for led in leds:
		if led:
			var r = randi()%256
			var g = randi()%256
			var b = randi()%256
			led.set_rgb_with_bytes_0_255(r, g, b)



func _ready() -> void:
	_recusrive_add_leds_from_parent(parent_node_of_leds)



func _recusrive_add_leds_from_parent(node:Node)->void:
	if node:
		for child in node.get_children():
			if child is SensorViewLedRgbColor:
				leds.append(child)
			_recusrive_add_leds_from_parent(child)
