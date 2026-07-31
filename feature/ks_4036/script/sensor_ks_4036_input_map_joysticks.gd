class_name SensorKs4036InputMapSingleJoystick
extends Node


signal on_single_joystick_updated(joystick_input: Vector2)
signal on_single_joystick_changed(joystick_input: Vector2)

@export var use_input: bool = true
func set_as_using_input(is_on: bool) -> void:
	use_input = is_on

@export var input_map_action_up: String = "ui_up"
@export var input_map_action_down: String = "ui_down"
@export var input_map_action_left: String = "ui_left"
@export var input_map_action_right: String = "ui_right"

@export_group("Debug")
@export var last_joystick_input: Vector2 = Vector2.ZERO



func _process(delta: float) -> void:
	if not use_input:
		return

	var joystick_input = Input.get_vector(input_map_action_left, input_map_action_right,  input_map_action_down, input_map_action_up)
	joystick_input.x = clamp(joystick_input.x, -1.0, 1.0)
	joystick_input.y = clamp(joystick_input.y, -1.0, 1.0)
	if joystick_input != last_joystick_input:
		last_joystick_input = joystick_input
		on_single_joystick_changed.emit(joystick_input)
	on_single_joystick_updated.emit(joystick_input)
