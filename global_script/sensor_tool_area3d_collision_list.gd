class_name SensorToolArea3DCollisionList
extends Node


signal on_collision_list_updated(nodes:Array[Node])
signal on_collision_filtered_list_updated(nodes:Array[Node])


@export var area3d_to_area3d:bool = false
@export var area3d_to_body:bool = true
@export var use_exploration_for_filter: bool = true

@export var node_in_collision_list: Array[Node] = []
@export var filter_configuration:SensorToolResourceFilterNodeBy
@export var node_in_collision_list_filtered: Array[Node] = []


func update_collision_list():
	if filter_configuration:
		if use_exploration_for_filter:
			node_in_collision_list_filtered = filter_configuration.filter_nodes_valid_with_recursive_exploration(node_in_collision_list)
		else:
			node_in_collision_list_filtered = filter_configuration.filter_nodes_valid_without_exploration(node_in_collision_list)	
	else:
		node_in_collision_list_filtered = node_in_collision_list.duplicate()
	on_collision_list_updated.emit(node_in_collision_list_filtered)
	on_collision_filtered_list_updated.emit(node_in_collision_list_filtered)
 


func _on_body_entered(body: Node) -> void:
	if not area3d_to_body:
		return
	if node_in_collision_list.has(body):
		return
	node_in_collision_list.append(body)
	update_collision_list()

func _on_body_exited(body: Node) -> void:
	if not area3d_to_body:
		return
	if not node_in_collision_list.has(body):
		return
	node_in_collision_list.erase(body)
	update_collision_list()


func _on_area_entered(area: Area3D) -> void:
	if not area3d_to_area3d:
		return
	if node_in_collision_list.has(area):
		return
	node_in_collision_list.append(area)
	update_collision_list()
	
func _on_area_exited(area: Area3D) -> void:
	if not area3d_to_area3d:
		return
	if not node_in_collision_list.has(area):
		return
	node_in_collision_list.erase(area)
	update_collision_list()
