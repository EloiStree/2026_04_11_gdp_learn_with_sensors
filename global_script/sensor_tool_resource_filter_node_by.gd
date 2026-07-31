class_name SensorToolResourceFilterNodeBy
extends Resource

@export var explore_parent_nodes: bool = false
@export var explore_child_nodes: bool = true

@export var use_layer_mask: bool = false
@export_flags_3d_physics var layer_mask_filter: int = 0xFFFFFFFF

@export var white_list_groups: Array[String] = []
@export var black_list_groups: Array[String] = []

@export var script_tag_white_list: Array[Script] = []
@export var script_tag_black_list: Array[Script] = []


func has_one_valid_node_with_exploration(node: Node) -> bool:
	if explore_parent_nodes:
		var current_node = node
		while current_node:
			if is_node_valid_no_exploration(current_node):
				return true
			current_node = current_node.get_parent() as Node
	elif explore_child_nodes:
		var nodes_to_check := [node]
		while nodes_to_check.size() > 0:
			var current_node = nodes_to_check.pop_front()
			if is_node_valid_no_exploration(current_node):
				return true
			for child in current_node.get_children():
				if child is Node:
					nodes_to_check.append(child)
	else:
		return is_node_valid_no_exploration(node)
	return false


func filter_nodes_valid_without_exploration(nodes: Array[Node]) -> Array[Node]:
	var valid_nodes := []
	for node in nodes:
		if is_node_valid_no_exploration(node):
			valid_nodes.append(node)
	return valid_nodes


func is_node_valid_no_exploration(node: Node) -> bool:
	if use_layer_mask:
		if not (node.collision_layer & 	layer_mask_filter):
			return false

	if white_list_groups.size() > 0:
		for group in white_list_groups:
			if node.is_in_group(group):
				return true

	if black_list_groups.size() > 0:
		for group in black_list_groups:
			if node.is_in_group(group):
				return false

	if script_tag_white_list.size() > 0:
		if is_script_in_white_list_check_not_recursive(node):
			return true

	if script_tag_black_list.size() > 0:
		if is_script_in_black_list_check_not_recursive(node):	
			return false

	return true


func is_script_in_white_list_check_not_recursive(node: Node) -> bool:
	var script = node.get_script()
	if script ==null:
		return false
	for list_script in script_tag_white_list:
		if script == list_script:
			return true
	return false

func is_script_in_black_list_check_not_recursive(node: Node) -> bool:
	var script = node.get_script()
	if script ==null:
		return false
	for list_script in script_tag_black_list:
		if script == list_script:
			return true
	return false
