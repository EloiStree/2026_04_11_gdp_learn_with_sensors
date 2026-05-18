class_name SensorKs4036InputMapFourButtons
extends Node


signal on_four_buttons_updated(front_left: bool, front_right: bool, back_left: bool, back_right: bool)
signal on_four_buttons_changed(front_left: bool, front_right: bool, back_left: bool, back_right: bool)

@export var use_input: bool = true
func set_as_using_input(is_on: bool) -> void:
	use_input = is_on

@export var input_map_left_front: String = "motor_left_front"
@export var input_map_right_front: String = "motor_right_front"
@export var input_map_left_back: String = "motor_left_back"
@export var input_map_right_back: String = "motor_right_back"

var last_front_left: bool = false
var last_front_right: bool = false
var last_back_left: bool = false
var last_back_right: bool = false

func _process(delta: float) -> void:
	if not use_input:
		return
	var front_left = Input.is_action_pressed(input_map_left_front)
	var front_right = Input.is_action_pressed(input_map_right_front)
	var back_left = Input.is_action_pressed(input_map_left_back)
	var back_right = Input.is_action_pressed(input_map_right_back)
	if front_left != last_front_left or front_right != last_front_right or back_left != last_back_left or back_right != last_back_right:
		last_front_left = front_left
		last_front_right = front_right
		last_back_left = back_left
		last_back_right = back_right
		on_four_buttons_changed.emit(front_left, front_right, back_left, back_right)
	on_four_buttons_updated.emit(front_left, front_right, back_left, back_right)
