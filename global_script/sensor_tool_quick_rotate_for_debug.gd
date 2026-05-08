class_name SensorToolQuickRotateForDebug
extends Node


@export var what_to_rotate:Node3D
@export var angle_per_seconds:float=90
@export var axis_rotation:Vector3= Vector3.UP
@export var rotation_is_global:bool = false

func _process(delta: float) -> void:
	if not what_to_rotate:
		return
	var angle_to_rotate := angle_per_seconds * delta
	var angle_to_rotate_in_rad = deg_to_rad(angle_to_rotate)
	if rotation_is_global:
		what_to_rotate.rotate_object_local(axis_rotation, angle_to_rotate_in_rad)
	else:
		what_to_rotate.rotate(axis_rotation, angle_to_rotate_in_rad)
