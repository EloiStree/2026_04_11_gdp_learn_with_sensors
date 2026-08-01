class_name SensorKS4036ScriptsToFacade
extends Node


@export var in_out_facade: SensorKS4036InOutFacade

@export var  ultrasonic_sensor_front: SensorToolRaycastToDistance
@export var  motor_left_and_right: SensorKS4036Move
@export var  led_left: SensorViewLedRgbColor
@export var  led_right: SensorViewLedRgbColor
#@export var  black_line_tracker_left_right : SensorKS4036SubViewToTwoLinesPixel
@export var  black_line_left_tracker:SensorToolNodeToMesh3DColor
@export var  black_line_right_tracker:SensorToolNodeToMesh3DColor

@export var  light_resistance_left: SensorLightResistorListener
@export var  light_resistance_right: SensorLightResistorListener
@export var  wheel_rotation_state_left:SensorKS4036WheelAngle0To360UpClockwise
@export var  wheel_rotation_state_right:SensorKS4036WheelAngle0To360UpClockwise


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
@export var _wheel_center_radius_reference: Node3D
@export var _wheel_out_radius_reference: Node3D



func _process(delta: float) -> void:
	in_out_facade._front_distance_in_meter = ultrasonic_sensor_front.get_distance_in_meter()
	in_out_facade._motor_left_percent_11 = motor_left_and_right.get_motor_left_value_as_percent_11()
	in_out_facade._motor_right_percent_11 = motor_left_and_right.get_motor_right_value_as_percent_11()
	in_out_facade._black_line_tracker_left = black_line_left_tracker.is_color_black(0.2)
	in_out_facade._black_line_tracker_right = black_line_right_tracker.is_color_black(0.2)
	in_out_facade._left_light_resistance_percent_01 = light_resistance_left.get_light_as_percent()
	in_out_facade._right_light_resistance_percent_01 = light_resistance_right.get_light_as_percent()
	in_out_facade._led_color_left_rgb = led_left.get_color_given()
	in_out_facade._led_color_right_rgb = led_right.get_color_given()
	in_out_facade._world_position_between_wheels = _center_of_wheels_transform.global_position
	in_out_facade._world_rotation_between_wheels = Quaternion.from_euler(_center_of_wheels_transform.global_rotation)
	var angle_counter_clockwise = get_angle_counter_clockwise_from_up_vector(in_out_facade._world_rotation_between_wheels)
	in_out_facade._world_up_rotation_0_360_counter_clockwise = angle_counter_clockwise
	
	in_out_facade._wheel_left_rotation_forward_0_360 = wheel_rotation_state_left.get_angle_0_to_360_up_clockwise()	
	in_out_facade._wheel_right_rotation_forward_0_360 = wheel_rotation_state_right.get_angle_0_to_360_up_clockwise()
	in_out_facade._line_tracker_color_left = black_line_left_tracker.get_any_color_found(Color.BLACK)
	in_out_facade._line_tracker_color_right = black_line_right_tracker.get_any_color_found(Color.BLACK)


	refresh_local_transforms()

func get_angle_counter_clockwise_from_up_vector(rotation: Quaternion) -> float:
	var forward :Vector3= rotation * Vector3(0, 0, -1)
	var angle_radians = atan2(forward.x, forward.z)
	var angle_degrees = rad_to_deg(angle_radians)
	angle_degrees += -180
	if angle_degrees < 0:
		angle_degrees += 360
	return angle_degrees

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

	in_out_facade._distance_between_wheels_in_meter = _left_wheel_transform.global_position.distance_to(_right_wheel_transform.global_position)
	in_out_facade._radius_of_wheels_in_meter = _center_of_wheels_transform.global_position.distance_to(_wheel_out_radius_reference.global_position)




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
