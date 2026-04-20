class_name SensorViewSetColorMaterial
extends Node


signal on_material_color_updated(color:StandardMaterial3D)
signal on_material_color_updated_for_surface_0(index:int,color:StandardMaterial3D)

@export var material_to_use:StandardMaterial3D
@export var use_duplicate_at_ready:bool=true
@export_group("Debug")
@export var material_to_affect:StandardMaterial3D

func _ready() -> void:
	if use_duplicate_at_ready:
		material_to_affect = material_to_use.duplicate() as StandardMaterial3D
	else:
		material_to_affect = material_to_use

func set_color(color:Color)->void:
	material_to_affect.albedo_color = color
	on_material_color_updated.emit(material_to_affect)
	on_material_color_updated_for_surface_0.emit(0, material_to_affect)
