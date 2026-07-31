class_name SensorIrReceiverSquare
extends Node




static func send_ir_integer_message_to_all_receiver_in_scene(value: int) -> void:
	for receiver in SensorIrReceiverSquare.receiver_in_scene:
		receiver.notify_an_received_ir_integer_message(value)

static var receiver_in_scene:Array[SensorIrReceiverSquare] = []


signal on_ir_integer_message_received(value: int)


@export var ir_forward_direction:Node3D


func _ready() -> void:
	receiver_in_scene.append(self)


func _exit_tree() -> void:
	receiver_in_scene.erase(self)

#@export var debug_print_received_message: bool = true

func notify_an_received_ir_integer_message(value: int) -> void:
	on_ir_integer_message_received.emit(value)
	#if debug_print_received_message:
	#	print("Received IR integer message: ", value, " at receiver: ", self.name)




static func sent_ir_integer_to_receiver_in_cone(value: int, start_point:Vector3, distance_point:Vector3, angle_point:Vector3) -> Array[SensorIrReceiverSquare]:
	var distance_cone = (distance_point - start_point).length()
	var angle_cone = rad_to_deg((angle_point - start_point).angle_to((distance_point - start_point).normalized()))
	var receivers_in_cone:Array[SensorIrReceiverSquare] = []
	for receiver in SensorIrReceiverSquare.receiver_in_scene:
		var receiver_position:Vector3 = receiver.ir_forward_direction.global_transform.origin
		var start_to_receiver_direction = receiver_position - start_point
		var start_to_receiver_distance = start_to_receiver_direction.length()
		if start_to_receiver_distance > distance_cone:
			continue
		var angle_direction_to_receiver = rad_to_deg((distance_point - start_point).normalized().angle_to(start_to_receiver_direction.normalized()))
		if angle_direction_to_receiver > angle_cone:
			continue
		receivers_in_cone.append(receiver)
		receiver.notify_an_received_ir_integer_message(value)
	return receivers_in_cone
