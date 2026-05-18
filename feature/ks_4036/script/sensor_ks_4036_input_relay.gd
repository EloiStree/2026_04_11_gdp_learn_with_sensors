class_name SensorKs4036InputRelay
extends Node


static var instance_in_scene: SensorKs4036InputRelay = null
static func get_instance():
	return instance_in_scene

signal on_joystick_input_received(input_joystick: Vector2)

signal on_wheels_input_received(left_percent: float, right_percent: float)
signal on_wheels_motors_input_received(top_left: bool, top_right: bool, bottom_left: bool, bottom_right: bool)

signal on_color_led_front_left_updated(color: Color)
signal on_color_led_front_right_updated(color: Color)
signal on_color_led_under_car_updated(color_front_left: Color, color_front_right: Color, color_back_left: Color, color_back_right: Color)

signal on_human_debug_input_enable(enable_input: bool)

func _ready() -> void:
	instance_in_scene = self

func _exit_tree() -> void:
	instance_in_scene = null

func clamp_percent(percent: float) -> float:
	return clamp(percent, -1.0, 1.0)



func set_human_input_enabled(is_enabled: bool) -> void:
	on_human_debug_input_enable.emit(is_enabled)

func disable_human_input():
	set_human_input_enabled(false)

#region Joystick Input
@export_group("Joystick Input")
@export var last_joystick_input: Vector2 = Vector2.ZERO
func set_input_with_array(input_joystick: Vector2) -> void:
	var stick = Vector2(clamp_percent(input_joystick.x), clamp_percent(input_joystick.y))
	last_joystick_input = stick
	on_joystick_input_received.emit(stick)
#endregion


#region Wheels Percent Power Input
@export_group("Wheels Input")
@export var last_wheel_left_percent_11: float = 0.0
@export var last_wheel_right_percent_11: float = 0.0

func set_left_wheel_percent_11(percent: float) -> void:
	set_wheels_percent_11(percent, last_wheel_right_percent_11)

func set_right_wheel_percent_11(percent: float) -> void:
	set_wheels_percent_11(last_wheel_left_percent_11, percent)

func set_wheels_percent_11(left_percent: float, right_percent: float) -> void:
	last_wheel_left_percent_11 = clamp_percent(left_percent)
	last_wheel_right_percent_11 = clamp_percent(right_percent)
	on_wheels_input_received.emit(last_wheel_left_percent_11, last_wheel_right_percent_11)
#endregion

#region MOTORS INPUT
@export_group("Motors Input")
@export var last_top_left_motor: bool = false
@export var last_top_right_motor: bool = false
@export var last_down_left_motor: bool = false
@export var last_down_right_motor: bool = false

func set_wheels_motors(top_left: bool, top_right: bool, bottom_left: bool, bottom_right: bool) -> void:
	last_top_left_motor = top_left
	last_top_right_motor = top_right
	last_down_left_motor = bottom_left
	last_down_right_motor = bottom_right
	on_wheels_motors_input_received.emit(top_left, top_right, bottom_left, bottom_right)

func set_top_left_motor_button(set_motor_on: bool) -> void:
	set_wheels_motors(set_motor_on, last_top_right_motor, last_down_left_motor, last_down_right_motor)

func set_top_right_motor_button(set_motor_on: bool) -> void:
	set_wheels_motors(last_top_left_motor, set_motor_on, last_down_left_motor, last_down_right_motor)

func set_down_left_motor_button(set_motor_on: bool) -> void:
	set_wheels_motors(last_top_left_motor, last_top_right_motor, set_motor_on, last_down_right_motor)

func set_down_right_motor_button(set_motor_on: bool) -> void:
	set_wheels_motors(last_top_left_motor, last_top_right_motor, last_down_left_motor, set_motor_on)

#endregion

#region LEDs Color
@export_group("LEDs Color")
@export var last_color_led_front_left: Color = Color(0, 0, 0)
@export var last_color_led_front_right: Color = Color(0, 0,0)
@export var last_color_led_under_car_front_left: Color = Color(0, 0, 0)
@export var last_color_led_under_car_front_right: Color = Color(0, 0, 0)
@export var last_color_led_under_car_back_left: Color = Color(0, 0, 0)
@export var last_color_led_under_car_back_right: Color = Color(0, 0, 0)

func set_color_led_front_left(color: Color) -> void:
	last_color_led_front_left = color
	on_color_led_front_left_updated.emit(color)

func set_color_led_front_right(color: Color) -> void:
	last_color_led_front_right = color
	on_color_led_front_right_updated.emit(color)

func set_color_led_under_car(color_front_left: Color, color_front_right: Color, color_back_left: Color, color_back_right: Color) -> void:
	last_color_led_under_car_front_left = color_front_left
	last_color_led_under_car_front_right = color_front_right
	last_color_led_under_car_back_left = color_back_left
	last_color_led_under_car_back_right = color_back_right
	on_color_led_under_car_updated.emit(color_front_left, color_front_right, color_back_left, color_back_right)

#endregion
