class_name SensorViewSetColorMeshInstance3D
extends Node

@export var mesh_instance:MeshInstance3D
@export var use_duplicate_at_ready:bool=true

@export_group("Debug")
@export var material_to_duplicated:StandardMaterial3D


func _ready() -> void:
	if use_duplicate_at_ready and mesh_instance and mesh_instance.mesh:
		var material = mesh_instance.mesh.surface_get_material(0) as StandardMaterial3D
		if material:
			material_to_duplicated = material.duplicate() as StandardMaterial3D
			mesh_instance.mesh.surface_set_material(0, material_to_duplicated)

func set_color(color:Color)->void:
	if material_to_duplicated:
		material_to_duplicated.albedo_color = color
		mesh_instance.mesh.surface_set_material(0, material_to_duplicated)
