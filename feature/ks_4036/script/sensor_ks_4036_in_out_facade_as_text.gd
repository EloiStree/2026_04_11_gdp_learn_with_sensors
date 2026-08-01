class_name SensorKS4036InOutFacadeAsText
extends Node


signal on_fixed_info_updated(new_value:String)
signal on_updated_info_updated(new_value:String)
signal on_any_info_updated(new_value:String)
signal on_both_joined_info_updated(new_value:String)
@export var _ks_4036: SensorKS4036InOutFacade
@export var _auto_update_this_script: bool = true

@export_multiline()
var _fixedContext:String 

@export_multiline()
var _updatedContext:String 



@export
var _at_ready_wait_for_fixed_update:float =1

func _ready() -> void:
	await get_tree().create_timer(_at_ready_wait_for_fixed_update).timeout
	if _auto_update_this_script:
		refresh_fixed_info_and_emit()
	
func _physics_process(delta: float) -> void:
	if _auto_update_this_script:
		refresh_updated_info_and_emit()
	
func refresh_fixed_info_and_emit() -> void:	
	var text = "Fixed Info:\n"
	text += "Distance Between Wheels: " + str(_ks_4036._distance_between_wheels_in_meter) + " m\n"
	text += "Radius of Wheels: " + str(_ks_4036._radius_of_wheels_in_meter) + " m\n"
	text += "Max Rotation Degree Per Second: " + str(_ks_4036._max_rotation_degree_per_seconds) + "\n"
	text += "Local Left Line Sensor From Center Wheel: " + str(_ks_4036._local_left_line_tracker_from_center_wheel) + "\n"
	text += "Local Right Line Sensor From Center Wheel: " + str(_ks_4036._local_right_line_tracker_from_center_wheel) + "\n"
	text += "Local Left Light Resistor From Center Wheel: " + str(_ks_4036._local_left_light_resistor_from_center_wheel) + "\n"
	text += "Local Right Light Resistor From Center Wheel: " + str(_ks_4036._local_right_light_resistor_from_center_wheel) + "\n"
	text += "Local Center Ultrasonic Sensor From Center Wheel: " + str(_ks_4036._local_front_ultrasonic_sensor_from_center_wheel) + "\n"
	text += "Local Left LED From Center Wheel: " + str(_ks_4036._local_left_led_from_center_wheel) + "\n"
	text += "Local Right LED From Center Wheel: "+ str(_ks_4036._local_right_led_from_center_wheel) + "\n"
	_fixedContext = text
	on_fixed_info_updated.emit( text)
	on_any_info_updated.emit(text)
	pass

func refresh_updated_info_and_emit() -> void:
	var text = "Updated Info:\n"
	text += "Front Distance: " + str(_ks_4036._front_distance_in_meter) + " m\n"
	text += "Motor Left Percent: " + str(_ks_4036._motor_left_percent_11) + "\n"
	text += "Motor Right Percent: " + str(_ks_4036._motor_right_percent_11) + "\n"
	text += "LED Left Color: " + str(_ks_4036._led_color_left_rgb) + "\n"
	text += "LED Right Color: "+ str(_ks_4036._led_color_right_rgb) + "\n"
	text += "Black Line Tracker Left: " + str(_ks_4036._black_line_tracker_left) + "\n"
	text += "Black Line Tracker Right: " + str(_ks_4036._black_line_tracker_right) + "\n"
	text += "Left Light Resistance Percent: " + str(_ks_4036._left_light_resistance_percent_01) + "\n"
	text += "Right Light Resistance Percent: " + str(_ks_4036._right_light_resistance_percent_01) + "\n"
	text += "World Position Between Wheels: " + str(_ks_4036._world_position_between_wheels) + "\n"
	text += "World Rotation Between Wheels: " + str(_ks_4036._world_rotation_between_wheels) + "\n"
	text += "World Up Rotation (0-360 Counter Clockwise): " + str(_ks_4036._world_up_rotation_0_360_counter_clockwise) + "\n"
	text += "Wheel Left Rotation Forward (0-360): " + str(_ks_4036._wheel_left_rotation_forward_0_360) + "\n"
	text += "Wheel Right Rotation Forward (0-360): " + str(_ks_4036._wheel_right_rotation_forward_0_360) + "\n"
	text += "Line Tracker Color Left: " + str(_ks_4036._line_tracker_color_left) + "\n"
	text += "Line Tracker Color Right: " + str(_ks_4036._line_tracker_color_right) + "\n"
	_updatedContext = text
	on_updated_info_updated.emit(text)
	on_any_info_updated.emit(text)
	on_both_joined_info_updated.emit(_fixedContext + "\n" + _updatedContext)
	
	pass
