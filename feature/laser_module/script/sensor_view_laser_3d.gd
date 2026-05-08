class_name SensorViewLaser3D
extends Node


@export var use_raycast_to_update_laser: bool = true
@export var ray_cast_3d: RayCast3D

@export var sphere_point_start_node:Node3D
@export var sphere_point_end_node:Node3D
@export var cylinder_ray_node:Node3D
@export var laser_radius: float = 0.05

@export var mod_disable_end_point_when_no_collision: bool = true
@export var mod_disable_ray_point_when_no_collision: bool = true

@export_group("Debug")
@export var from_point: Vector3 = Vector3.ZERO
@export var to_point: Vector3 = Vector3.ZERO




func show_laser_start_point(show: bool) -> void:
	if sphere_point_start_node:
		sphere_point_start_node.visible = show

func show_laser_end_point(show: bool) -> void:
	if sphere_point_end_node:
		sphere_point_end_node.visible = show
func show_laser_ray(show: bool) -> void:
	if cylinder_ray_node:
		cylinder_ray_node.visible = show	

func get_ray_cast_start() -> Vector3:
	if not use_raycast_to_update_laser:
		return from_point

	if not ray_cast_3d:
		return Vector3.ZERO	
	return ray_cast_3d.global_position

func get_ray_cast_end() -> Vector3:

	if not use_raycast_to_update_laser:
		return to_point



	if not ray_cast_3d:
		return Vector3.ZERO
	var start_point: Vector3 = ray_cast_3d.global_position
	var q_forward: Vector3 = -ray_cast_3d.global_transform.basis.z.normalized()
	var end = ray_cast_3d.to_global(ray_cast_3d.target_position)
	var end_point: Vector3 = start_point + end
	var is_colliding = ray_cast_3d.is_colliding()
	if is_colliding:
		end_point = ray_cast_3d.get_collision_point()
	return end_point	

func _process(delta: float) -> void:
	if not ray_cast_3d:
		return
	ray_cast_3d.force_raycast_update()	
	var start_point: Vector3 = get_ray_cast_start()
	var end_point: Vector3 = get_ray_cast_end()

	#DebugDraw3D.draw_line(start_point, end_point, Color(1, 0, 0),0.05)

	var direction: Vector3 = (end_point - start_point).normalized()
	var distance: float = start_point.distance_to(end_point)
	var q_direction: Quaternion = quat_from_direction(direction)
	
	if sphere_point_start_node:
		sphere_point_start_node.global_position = start_point
		sphere_point_start_node.scale = Vector3(laser_radius, laser_radius, laser_radius)
		
		# set direction
		sphere_point_start_node.rotation = q_direction.get_euler()

	if sphere_point_end_node:
		sphere_point_end_node.global_position = end_point
		sphere_point_end_node.scale = Vector3(laser_radius, laser_radius, laser_radius)
		sphere_point_end_node.rotation = q_direction.get_euler()

	if cylinder_ray_node:
		cylinder_ray_node.global_transform.origin = start_point+direction * distance * 0.5
		cylinder_ray_node.look_at(end_point, Vector3.UP)
		cylinder_ray_node.scale = Vector3(laser_radius, laser_radius, distance)

	if mod_disable_end_point_when_no_collision and not ray_cast_3d.is_colliding():
		show_laser_end_point(false)
	elif mod_disable_end_point_when_no_collision and ray_cast_3d.is_colliding():
		show_laser_end_point(true)

	if mod_disable_ray_point_when_no_collision and not ray_cast_3d.is_colliding():
		show_laser_ray(false)
	elif mod_disable_ray_point_when_no_collision and ray_cast_3d.is_colliding():
		show_laser_ray(true)
	


func quat_from_direction(direction: Vector3) -> Quaternion:
	var forward = Vector3(0, 0, -1)
	var dir = direction.normalized()

	var dot = forward.dot(dir)

	# Same direction
	if dot > 0.9999:
		return Quaternion.IDENTITY

	# Opposite direction
	if dot < -0.9999:
		return Quaternion(Vector3.UP, PI)

	var axis = forward.cross(dir).normalized()
	var angle = acos(dot)

	return Quaternion(axis, angle)
