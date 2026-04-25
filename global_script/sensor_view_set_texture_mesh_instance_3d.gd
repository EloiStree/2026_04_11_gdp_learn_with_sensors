class_name SensorViewSetTextureMeshInstance3D
extends Node

@export var mesh_instance: MeshInstance3D
@export var use_duplicate_at_ready: bool = true

@export_group("Debug")
@export var material_to_duplicated: StandardMaterial3D

func _ready() -> void:

	if not mesh_instance or not mesh_instance.mesh:
		return
	

	var material := mesh_instance.get_surface_override_material(0)
	
	if material:
		material_to_duplicated = material.duplicate() as StandardMaterial3D
		if use_duplicate_at_ready:
			mesh_instance.set_surface_override_material(0, material_to_duplicated)


func set_texture(texture: Texture2D) -> void:
	print("set_texture called with texture: ", texture)
	if not mesh_instance or not mesh_instance.mesh:
		return
	
	print("set_A ", texture)
	if not material_to_duplicated:
		return

	print("set_B", texture)
	material_to_duplicated.albedo_texture = texture
