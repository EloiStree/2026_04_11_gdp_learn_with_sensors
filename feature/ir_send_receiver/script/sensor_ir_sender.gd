class_name SensorIrSender
extends Node


enum KeyeStudioStandard {
	Left = 68,
	Right = 67,
	Down = 21,
	Up = 70,
	OK = 64,
	_1 = 11,
	_2 = 25,
	_3 = 13,
	_4 = 12,
	_5 = 24,
	_6 = 94,
	_7 = 8,
	_8 = 28,
	_9 = 90,
	_star = 66,
	_hash = 74,
}


signal on_ir_integer_message_pushed(value: int)


@export var send_to_all_receiver_in_scene: bool = true




func push_ir_integer_message(value: int) -> void:
	on_ir_integer_message_pushed.emit(value)
	print("Sending integer", value)
	if send_to_all_receiver_in_scene:
		SensorIrReceiverSquare.send_ir_integer_message_to_all_receiver_in_scene(value)

func push_ir_integer_message_by_keye_studio_standard(value: KeyeStudioStandard) -> void:
	push_ir_integer_message(value)

func push_ir_keye_up() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard.Up)

func push_ir_keye_down() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard.Down)

func push_ir_keye_left() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard.Left)

func push_ir_keye_right() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard.Right)

func push_ir_keye_ok() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard.OK)

func push_ir_keye_1() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._1)

func push_ir_keye_2() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._2)

func push_ir_keye_3() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._3)

func push_ir_keye_4() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._4)

func push_ir_keye_5() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._5)	

func push_ir_keye_6() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._6)

func push_ir_keye_7() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._7)

func push_ir_keye_8() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._8)	

func push_ir_keye_9() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._9)

func push_ir_keye_star() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._star)

func push_ir_keye_hash() -> void:
	push_ir_integer_message_by_keye_studio_standard(KeyeStudioStandard._hash)
