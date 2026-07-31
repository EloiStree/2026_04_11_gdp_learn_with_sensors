## I did it once in unity to scan in 3D an object and turn it into voxel.
## I know it is possible. I just dont know how in Godot.

extends Node3D

func _ready() -> void:
	# Example: cast downward from above
	var origin: Vector3 = Vector3(0.0, 10.0, 0.0)
	var direction: Vector3 = Vector3.DOWN
	
	raycast_and_get_color(origin, direction, 50.0)


func raycast_and_get_color(origin: Vector3, direction: Vector3, length: float) -> void:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var from: Vector3 = origin
	var to: Vector3 = origin + direction.normalized() * length
	
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = false
	
	var result: Dictionary = space_state.intersect_ray(query)
	
	if result.is_empty():
		print("No hit")
		return
	
	var collider: Object = result["collider"]
	
	if collider is not MeshInstance3D:
		print("Hit is not a MeshInstance3D")
		return
	
	var mesh_instance: MeshInstance3D = collider
	var surface_index: int = result.get("shape", 0)
	
	var material: Material = mesh_instance.get_active_material(surface_index)
	
	if material is not StandardMaterial3D:
		print("Material not StandardMaterial3D")
		return
	
	var std_mat: StandardMaterial3D = material
	var final_color: Color
	
	# --- Try UV + texture ---
	if result.has("uv") and std_mat.albedo_texture != null:
		var uv: Vector2 = result["uv"]
		var texture: Texture2D = std_mat.albedo_texture
		var image: Image = texture.get_image()
		
		if image != null:
			image.lock()
			
			var width: int = image.get_width()
			var height: int = image.get_height()
			
			var x: int = clamp(int(uv.x * width), 0, width - 1)
			var y: int = clamp(int(uv.y * height), 0, height - 1)
			
			var pixel_color: Color = image.get_pixel(x, y)
			
			image.unlock()
			
			# Combine with albedo color (Godot usually multiplies them)
			final_color = pixel_color * std_mat.albedo_color
		else:
			final_color = std_mat.albedo_color
	else:
		# --- Fallback: no UV ---
		final_color = std_mat.albedo_color
	
	var hit_position: Vector3 = result["position"]
	var hit_normal: Vector3 = result["normal"]
	
	print("Hit position:", hit_position)
	print("Normal:", hit_normal)
	print("Final color:", final_color)
