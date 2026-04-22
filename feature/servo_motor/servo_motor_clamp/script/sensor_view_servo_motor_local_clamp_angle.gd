class_name SensorViewServoMotorLocalClampAngle
extends Node

@export var minus_angle: float = -90.0
@export var plus_angle: float = 90.0

@export var angle_percent_0_1: float = 0.0
@export var last_angle_set: float = 0.0

@export var pivot_node_to_rotate: Node3D
@export var rotation_axis: Vector3 = Vector3(1, 0, 0)
@export var use_clamp_to_limits: bool = true
@export var inverse_rotation_angle: bool = false


func set_with_analog_1023(analog_value_0_1023: int) -> void:
	var percent_0_1 := analog_value_0_1023 / 1023.0
	set_with_percent01(percent_0_1)

func set_with_analog_255(analog_value_0_255: int) -> void:
	var percent_0_1 := analog_value_0_255 / 255.0
	set_with_percent01(percent_0_1)
	

func set_at_full_open() -> void:
	set_with_percent01(1.0)

func set_at_full_close() -> void:
	set_with_percent01(0.0)

func set_at_middle() -> void:
	set_with_percent01(0.5)


func set_at_angle(angle: float) -> void:
	if use_clamp_to_limits:
		angle = clamp(angle, minus_angle, plus_angle)
	var percent_0_1 := (angle - minus_angle) / (plus_angle - minus_angle)
	set_with_percent01(percent_0_1)


func set_with_percent11(percent_1_to_1: float) -> void:
	var percent_0_1 := (percent_1_to_1 + 1.0) / 2.0
	set_with_percent01(percent_0_1)


func set_with_percent01(percent_0_1: float) -> void:
	if use_clamp_to_limits:
		angle_percent_0_1 = clamp(percent_0_1, 0.0, 1.0)
	else:
		angle_percent_0_1 = percent_0_1

	var angle := lerp(minus_angle, plus_angle, angle_percent_0_1)
	last_angle_set = angle

	if inverse_rotation_angle:
		angle = -angle
	var axis := rotation_axis.normalized()
	var local_quaternion := Quaternion(axis, deg_to_rad(angle))

	pivot_node_to_rotate.rotation = local_quaternion.get_euler()
