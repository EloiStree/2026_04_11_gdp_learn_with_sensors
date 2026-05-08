class_name SensorViewSetColorMeshInstance3D
extends Node

@export var mesh_instance:MeshInstance3D
@export var use_duplicate_at_ready:bool=true

@export_group("Debug")
@export var material_duplicated:StandardMaterial3D
@export var last_received_color:Color

var _duplicate_done:bool=false
func _ready() -> void:
	check_if_duplicated()


func check_if_duplicated() -> void:
	if _duplicate_done:
		return
	if use_duplicate_at_ready and mesh_instance and mesh_instance.mesh:
		_duplicate_done = true
		var material = mesh_instance.get_active_material(0) as StandardMaterial3D
		if material:
			material_duplicated = material.duplicate() as StandardMaterial3D
			mesh_instance.set_surface_override_material(0, material_duplicated)

func set_color(color:Color)->void:

	check_if_duplicated()
	last_received_color = color
	if use_duplicate_at_ready:
		if material_duplicated:
			material_duplicated.albedo_color = color
	else:
		if mesh_instance:
			var material = mesh_instance.get_active_material(0) as StandardMaterial3D
			if material:
				material.albedo_color = color
