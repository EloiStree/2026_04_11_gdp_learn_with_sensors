class_name SensorLightResistorListener
extends Node

static var scene_as_scanned: bool = false

static var list_of_spot_lights: Array[SpotLight3D] = []
static var list_of_directional_lights: Array[DirectionalLight3D] = []
static var list_of_omni_lights: Array[OmniLight3D] = []

signal on_light_intensity_updated(intensity: float)
signal on_light_intensity_percent_updated(percent: float)
signal on_light_intensity_digital_updated(is_receiving_light: bool)


@export var tracked_position: Node3D

@export var max_light_intensity: float = 1.0
@export var digital_threshold: float = 0.5
@export var update_interval: float = 0.1

@export_group("Debug")
@export var intensity_value: float = 0.0
@export var auto_update: bool = true

var _update_timer: float = 0.0
var _last_intensity: float = -1.0  # Force first update



func _ready() -> void:
	refresh_light_in_scene_if_not_load_yet()


func _process(delta: float) -> void:
	if not auto_update:
		return
		
	_update_timer += delta
	if _update_timer >= update_interval:
		_update_timer = 0.0
		update_light_intensity()


func update_light_intensity() -> void:
	var position = tracked_position.global_transform.origin
	var intensity := get_light_intensity_at(position)
	intensity_value = intensity
	
	var percent := clampf(intensity / max_light_intensity, 0.0, 1.0)
	
	# Emit signals (only when meaningfully changed)
	if abs(intensity - _last_intensity) > 0.001:
		_last_intensity = intensity
		on_light_intensity_updated.emit(intensity)
		on_light_intensity_percent_updated.emit(percent)
		on_light_intensity_digital_updated.emit(intensity >= digital_threshold)



func force_light_refresh_in_scene() -> void:
	scene_as_scanned = false
	
	list_of_spot_lights.clear()
	list_of_directional_lights.clear()
	list_of_omni_lights.clear()
	
	var all_nodes := _get_all_nodes()
	
	for node in all_nodes:
		if node is SpotLight3D:
			list_of_spot_lights.append(node)
		elif node is DirectionalLight3D:
			list_of_directional_lights.append(node)
		elif node is OmniLight3D:
			list_of_omni_lights.append(node)
	
	scene_as_scanned = true


func refresh_light_in_scene_if_not_load_yet() -> void:
	if not scene_as_scanned:
		force_light_refresh_in_scene()


func get_light_intensity_at(pos: Vector3) -> float:
	var total: float = 0.0
	
	# Directional Lights
	for light: DirectionalLight3D in list_of_directional_lights:
		if light.visible and light.light_energy > 0.0:
			total += light.light_energy
	
	# Omni Lights
	for light: OmniLight3D in list_of_omni_lights:
		if not light.visible or light.light_energy <= 0.0:
			continue
		var dist := light.global_position.distance_to(pos)
		if dist > light.omni_range:
			continue
			
		var attenuation := _calculate_attenuation(dist, light.omni_range)
		total += light.light_energy * attenuation
	
	# Spot Lights
	for light: SpotLight3D in list_of_spot_lights:
		if not light.visible or light.light_energy <= 0.0:
			continue
			
		var dist := light.global_position.distance_to(pos)
		if dist > light.spot_range:
			continue
			
		# Spot cone check (FIXED: degrees → radians)
		var direction_to_point := (pos - light.global_position).normalized()
		var spot_direction := -light.global_transform.basis.z.normalized()
		var angle_rad := acos(direction_to_point.dot(spot_direction))
		
		if angle_rad > deg_to_rad(light.spot_angle):
			continue
			
		var attenuation := _calculate_attenuation(dist, light.spot_range)
		total += light.light_energy * attenuation
	
	return total


func _calculate_attenuation(distance: float, range_val: float) -> float:
	if distance <= 0.0:
		return 1.0
	var normalized := distance / range_val
	return maxf(1.0 - normalized * normalized, 0.0)



func add_light_manually(light: Light3D) -> void:
	if light is SpotLight3D:
		if not list_of_spot_lights.has(light):
			list_of_spot_lights.append(light)
	elif light is DirectionalLight3D:
		if not list_of_directional_lights.has(light):
			list_of_directional_lights.append(light)
	elif light is OmniLight3D:
		if not list_of_omni_lights.has(light):
			list_of_omni_lights.append(light)


func clear_all_lights() -> void:
	list_of_spot_lights.clear()
	list_of_directional_lights.clear()
	list_of_omni_lights.clear()
	scene_as_scanned = false


func _get_all_nodes() -> Array[Node]:
	var all_nodes: Array[Node] = []
	_collect_nodes(get_tree().root, all_nodes)
	return all_nodes


func _collect_nodes(node: Node, array: Array[Node]) -> void:
	if not node:
		return
	array.append(node)
	for child in node.get_children():
		_collect_nodes(child, array)
