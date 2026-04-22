class_name SensorViewServoMotorLocalContinueAngle
extends Node

@export var angle_for_100_percent: float = 360.0
@export var last_angle_given: float = 0.0

@export var pivot_node_to_rotate: Node3D
@export var rotation_axis: Vector3 = Vector3(1, 0, 0)
@export var inverse_rotation_angle: bool = false



func set_at_angle(angle: float) -> void:
	var percent_0_1 := angle / angle_for_100_percent
	set_with_percent01(percent_0_1)

func set_with_percent11(percent_1_to_1: float) -> void:
	var percent_0_1 := (percent_1_to_1 + 1.0) / 2.0
	set_with_percent01(percent_0_1)

func set_with_percent01(percent_0_1: float) -> void:
	var angle := percent_0_1 * angle_for_100_percent
	last_angle_given = angle
	if inverse_rotation_angle:
		angle = -angle
	var axis := rotation_axis.normalized()
	var local_quaternion := Quaternion(axis, deg_to_rad(angle))
	pivot_node_to_rotate.rotation = local_quaternion.get_euler()
