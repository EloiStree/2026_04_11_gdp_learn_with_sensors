class_name SensorIrSenderCone
extends Node


@export var light_cone_start_point:Node3D
@export var light_cone_distance_point:Node3D
@export var light_cone_angle_point:Node3D

signal on_ir_integer_message_pushed(value: int, receiver:SensorIrReceiverSquare)

func push_ir_integer_message(value: int) -> void:
	var start_point = light_cone_start_point.global_transform.origin
	var distance_point = light_cone_distance_point.global_transform.origin
	var angle_point = light_cone_angle_point.global_transform.origin
	#print ("Sending integer", value, " from sender: ", self.name, " with cone start point: ", start_point, " distance point: ", distance_point, " angle point: ", angle_point)
	var touched:=SensorIrReceiverSquare.sent_ir_integer_to_receiver_in_cone(value, start_point, distance_point, angle_point)
	for receiver in touched:
		on_ir_integer_message_pushed.emit(value, receiver)
		#print ("Sent integer", value, " to receiver: ", receiver.name)



func override_cone_distance(distance: float) -> void:
	var direction = (light_cone_distance_point.global_transform.origin - light_cone_start_point.global_transform.origin).normalized()
	light_cone_distance_point.global_transform.origin = light_cone_start_point.global_transform.origin + direction * distance



func override_cone_angle(angle: float) -> void:
	## set point at distance to the right of y axis with angle local
	var adjacent_edge = get_distance()
	var opposite_edge = tan(deg_to_rad(angle)) * adjacent_edge
	var v2 = Vector3(0, opposite_edge, -adjacent_edge)
	
	light_cone_angle_point.local_transform.origin = v2

func get_start_point() -> Vector3:
	return light_cone_start_point.global_transform.origin

func get_forward_direction() -> Vector3:
	return (light_cone_distance_point.global_transform.origin - light_cone_start_point.global_transform.origin).normalized()


func get_distance() -> float:
	return (light_cone_distance_point.global_transform.origin - light_cone_start_point.global_transform.origin).length()

func get_angle() -> float:
	#angle between three points
	var v1 = light_cone_distance_point.global_transform.origin - light_cone_start_point.global_transform.origin
	var v2 = light_cone_angle_point.global_transform.origin - light_cone_start_point.global_transform.origin
	var angle = v1.angle_to(v2)
	return rad_to_deg(angle)
