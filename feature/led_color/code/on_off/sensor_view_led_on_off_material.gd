
## This one dont use duplicate material
class_name SensorViewLedOnOffMaterial
extends Node

signal on_led_on_off_changed(is_on:bool)
signal on_led_on_off_material_changed(is_on:bool)

@export var mesh_instance:Array[MeshInstance3D]
@export var material_on :StandardMaterial3D
@export var material_off :StandardMaterial3D


@export var use_default_value_on_ready:bool = true
@export var default_value_on_ready:bool = false

func set_led_on_off(is_on:bool)->void:
	var material_to_use:StandardMaterial3D = material_off
	
	if is_on:
		material_to_use = material_on
	for mesh in mesh_instance:
		mesh.set_surface_override_material(0, material_to_use)
	emit_signal("on_led_on_off_changed", is_on)
	emit_signal("on_led_on_off_material_changed", is_on)    

func _ready() -> void:
	if use_default_value_on_ready:
		set_led_on_off(default_value_on_ready)
