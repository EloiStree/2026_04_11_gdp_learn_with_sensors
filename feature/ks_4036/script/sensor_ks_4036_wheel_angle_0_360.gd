## Allows to know the wheel rotation based on a point rotationg around x axis clockwise forward from 0 to 360 degrees.
class_name SensorKS4036WheelAngle0To360UpClockwise
extends Node

signal on_angle_0_to_360_up_clockwise_updated(angle: float)

@export var _center_wheel_anchor: Node3D
@export var _wheel_mark_anchor: Node3D

@export var _angle_0_to_360_up_clockwise: float = 0.0

func _process(delta: float) -> void:

	var local_point :Vector3= get_world_to_local_point_from_root_position_rotation(
		_wheel_mark_anchor.global_position,
		_center_wheel_anchor.global_position,
		Quaternion.from_euler(_center_wheel_anchor.global_transform.basis.get_euler()))
	var angle = rad_to_deg(atan2(local_point.y, local_point.z))
	## value between 0 to 360  clockwise forward
	angle+=-90.0
	_angle_0_to_360_up_clockwise = fmod(angle + 360.0, 360.0)

	on_angle_0_to_360_up_clockwise_updated.emit(_angle_0_to_360_up_clockwise)

func get_angle_0_to_360_up_clockwise() -> float:
	return _angle_0_to_360_up_clockwise

static func get_world_to_local_point_from_root_position_rotation(
	world_position: Vector3,
 	position_reference: Vector3,
 	rotation_reference: Quaternion
  ) -> Vector3:
	return rotation_reference.inverse() * (world_position - position_reference)
