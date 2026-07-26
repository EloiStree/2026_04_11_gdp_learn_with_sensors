class_name SensorKS4036InOutFacade
extends Node3D

#region ABSTRACT SET SIGNAL INPUT
## Notify developer that player ask the motor to be in left percent power of -1 or 1.
signal on_motor_left_percent_11_set(new_value_percent_11: float)
## Notify developer that player ask the motor to be in right percent power of -1 or 1.
signal on_motor_right_percent_11_set(new_value_percent_11: float)

## Notify developer that player ask the LED on the left side to change color.
signal on_led_left_color_set(left_color: Color)
## Notify developer that player ask the LED on the right side to change color.
signal on_led_right_color_set(right_color: Color)

## Notify developer that player ask the display to change the content.
signal on_display_ssd1306_128x64_set(value_top_left_down_right: Array[bool])

#endregion

#region SET METHODS

func set_motors_percent_11(left_percent_11: float, right_percent_11: float) -> void:
	set_motor_left_percent_11(left_percent_11)
	set_motor_right_percent_11(right_percent_11)


func set_motor_left_percent_11(new_value_percent_11: float) -> void:
	_motor_left_percent_11 = new_value_percent_11
	on_motor_left_percent_11_set.emit(new_value_percent_11)

func set_motor_right_percent_11(new_value_percent_11: float) -> void:
	_motor_right_percent_11 = new_value_percent_11
	on_motor_right_percent_11_set.emit(new_value_percent_11)

func set_led_left_color(left_color: Color) -> void:
	_led_color_left_rgb = left_color
	on_led_left_color_set.emit(left_color)

func set_led_right_color(right_color: Color) -> void:
	_led_color_right_rgb = right_color
	on_led_right_color_set.emit(right_color)

func set_display_ssd1306_128x64(value_top_left_down_right: Array[bool]) -> void:
	_display_ssd1306_128x64 = value_top_left_down_right
	on_display_ssd1306_128x64_set.emit(value_top_left_down_right)

#endregion


#region VARIABLE
@export_group("Updated Value")

## Distance from the ultrasonic sensor at the front of the car to the front obstacle.
@export var _front_distance_in_meter : float = 0.0

## Percent from -1 to 1 where one means moving forward at the maximum rotation speed of the left motor.
@export var _motor_left_percent_11 : float = 0.0

## Percent from -1 to 1 where one means moving forward at the maximum rotation speed of the right motor.
@export var _motor_right_percent_11 : float = 0.0

## For debugging the left RGB LED state.
@export var _led_color_left_rgb : Color

## For debugging the right RGB LED state.
@export var _led_color_right_rgb : Color

## Whether the front-left line detector detects black.
@export var _black_line_tracker_left: bool = false

## Whether the front-right line detector detects black.
@export var _black_line_tracker_right: bool = false

## Percent from 0 to 1 of the analog light resistance on the left side of the car.
@export var _left_light_resistance_percent_01 : float = 0.0

## Percent from 0 to 1 of the analog light resistance on the right side of the car.
@export var _right_light_resistance_percent_01 : float = 0.0

## World position at the center of the wheels.
@export var _world_position_between_wheels: Vector3

## Real rotation in quaternion format at the center of the wheels.
@export var _world_rotation_between_wheels: Quaternion

## Euler rotation of the up axis in counter-clockwise rotation.
@export var _world_up_rotation_0_360_counter_clockwise: float

## Actual left wheel rotation, clockwise forward from 0 to 360 degrees.
@export var _wheel_left_rotation_forward_0_360: float

## Actual right wheel rotation, clockwise forward from 0 to 360 degrees.
@export var _wheel_right_rotation_forward_0_360: float


## Content of the display debug screen as 128x64 pixels true or false.
## Representing a SSD1306 Display .
@export var _display_ssd1306_128x64 : Array[bool] = []


@export_group("Fixed Value")

## Distance between the two wheels in meters.
@export var _distance_between_wheels_in_meter : float = 0.0

## Radius of the wheels of the car in meters.
@export var _radius_of_wheels_in_meter : float = 0.0

## Maximum rotation a wheel can perform when the motor speed is at 100%.
@export var _max_rotation_degree_per_seconds: float = 720.0


@export_group("Fixed Local Position")

@export var _local_left_line_sensor_from_center_wheel: Vector3
@export var _local_right_line_sensor_from_center_wheel: Vector3
@export var _local_left_light_resistor_from_center_wheel: Vector3
@export var _local_right_light_resistor_from_center_wheel: Vector3
@export var _local_center_ultrasonic_sensor_from_center_wheel: Vector3
@export var _local_left_led_from_center_wheel: Vector3
@export var _local_right_led_from_center_wheel: Vector3

#endregion


#region GET VARIABLE METHODS



#endregion
