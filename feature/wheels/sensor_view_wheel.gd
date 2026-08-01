class_name SensorViewWheel
extends Node

@export var what_to_rotate_node: Node3D
@export var rotation_point_node: Node3D

@export var inverse_rotation: bool = false

@export var last_set_rotation_in_degree: float = 0.0


func set_rotation_in_degree(degree_rotation: float) -> void:
	if not what_to_rotate_node or not rotation_point_node:
		return
	
	last_set_rotation_in_degree = degree_rotation
	
	# Reset to the pivot's transform (position + rotation)
	what_to_rotate_node.global_position = rotation_point_node.global_position
	what_to_rotate_node.global_rotation = rotation_point_node.global_rotation
	
	# Apply rotation around the pivot's X axis
	var direction :float= -1.0 if inverse_rotation else 1.0
	var angle_rad :float= deg_to_rad(degree_rotation)	
	what_to_rotate_node.rotate_object_local(Vector3.RIGHT * direction, angle_rad)
