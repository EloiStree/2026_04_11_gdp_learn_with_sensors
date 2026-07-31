class_name SensorKS4036ScriptsToFacade
extends Node


@export var in_out_facade: SensorKS4036InOutFacade

@export var  ultrasonic_sensor_front: SensorToolRaycastToDistance
@export var  motor_left_and_right: SensorKS4036Move
@export var  led_left: SensorViewLedRgbColor
@export var  led_right: SensorViewLedRgbColor
@export var  black_line_tracker_left_right : SensorKS4036SubViewToTwoLinesPixel
@export var  light_resistance_left: SensorLightResistorListener
@export var  light_resistance_right: SensorLightResistorListener

@export_group("Transforms")
@export var _center_of_wheels_transform: Node3D
@export var _left_wheel_transform: Node3D
@export var _right_wheel_transform: Node3D
@export var _front_ultrasonic_sensor_transform: Node3D
@export var _led_left_transform: Node3D
@export var _led_right_transform: Node3D
@export var _left_light_resistor_transform: Node3D
@export var _right_light_resistor_transform: Node3D
@export var _left_line_tracker_transform: Node3D
@export var _right_line_tracker_transform: Node3D



func _process(delta: float) -> void:
	in_out_facade._black_line_tracker_left = black_line_tracker_left_right.is_left_black(0.1)
	in_out_facade._black_line_tracker_right = black_line_tracker_left_right.is_right_black(0.1)
	in_out_facade._left_light_resistance_percent_01 = light_resistance_left.get_light_as_percent()
	in_out_facade._right_light_resistance_percent_01 = light_resistance_right.get_light_as_percent()
	in_out_facade._led_color_left_rgb = led_left.get_color_given()
	in_out_facade._led_color_right_rgb = led_right.get_color_given()
	in_out_facade._front_distance_in_meter = ultrasonic_sensor_front.get_distance_in_meter()
	#in_out_facade._motor_left_percent_11 = motor_left_and_right.get_motor_state_as_percent_11()
	#in_out_facade._motor_right_percent_11 = motor_left_and_right.get_motor_state_as_percent_11()
	#in_out_facade._world_position_between_wheels = motor_left_and_right._world_position_between_wheels
	#in_out_facade._world_rotation_between_wheels = motor_left_and_right._world_rotation_between_wheels
	#in_out_facade._wheel_left_rotation_forward_0_360 = motor_left_and_right._wheel_left_rotation_forward_0_360
	#in_out_facade._wheel_right_rotation_forward_0_360 = motor_left_and_right._wheel_right_rotation_forward_0_360
	#in_out_facade._display_ssd1306_128x64 = motor_left_and_right._display_ssd1306_128x64
	#refresh_local_transforms()


func refresh_local_transforms() -> void:

	var p :Vector3 = _center_of_wheels_transform.global_position
	var q :Quaternion = Quaternion.from_euler( _center_of_wheels_transform.global_rotation)

	in_out_facade._local_left_wheel_from_center_wheel = get_world_to_local_point(_left_wheel_transform.global_position, p, q)
	in_out_facade._local_right_wheel_from_center_wheel = get_world_to_local_point(_right_wheel_transform.global_position, p, q)
	in_out_facade._local_front_ultrasonic_sensor_from_center_wheel = get_world_to_local_point(_front_ultrasonic_sensor_transform.global_position, p, q)
	in_out_facade._local_left_led_from_center_wheel = get_world_to_local_point(_led_left_transform.global_position, p, q)
	in_out_facade._local_right_led_from_center_wheel = get_world_to_local_point(_led_right_transform.global_position, p, q)
	in_out_facade._local_left_light_resistor_from_center_wheel = get_world_to_local_point(_left_light_resistor_transform.global_position, p, q)
	in_out_facade._local_right_light_resistor_from_center_wheel = get_world_to_local_point(_right_light_resistor_transform.global_position, p, q)
	in_out_facade._local_left_line_tracker_from_center_wheel = get_world_to_local_point(_left_line_tracker_transform.global_position, p, q)
	in_out_facade._local_right_line_tracker_from_center_wheel = get_world_to_local_point(_right_line_tracker_transform.global_position, p, q)	




static func get_world_to_local_directional_point(world_position: Vector3, world_rotation: Quaternion, position_reference: Vector3, rotation_reference: Quaternion) -> Dictionary:
	var local_rotation: Quaternion = rotation_reference.inverse() * world_rotation
	var local_position: Vector3 = rotation_reference.inverse() * (world_position - position_reference)
	return {"local_position": local_position, "local_rotation": local_rotation}


static func get_local_to_world_directional_point(local_position: Vector3, local_rotation: Quaternion, position_reference: Vector3, rotation_reference: Quaternion) -> Dictionary:
	var world_rotation: Quaternion = rotation_reference * local_rotation
	var world_position: Vector3 = (rotation_reference * local_position) + position_reference
	return {"world_position": world_position, "world_rotation": world_rotation}

	
static func get_world_to_local_point(world_position: Vector3, position_reference: Vector3, rotation_reference: Quaternion) -> Vector3:
	var local_position: Vector3 = rotation_reference.inverse() * (world_position - position_reference)
	return local_position


static func get_local_to_world_point(local_position: Vector3, position_reference: Vector3, rotation_reference: Quaternion) -> Vector3:
	var world_position: Vector3 = (rotation_reference * local_position) + position_reference
	return world_position
