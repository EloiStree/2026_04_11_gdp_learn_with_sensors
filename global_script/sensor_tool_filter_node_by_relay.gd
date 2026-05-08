
## Received note and only broadcast the one that fit the filter
class_name SensorToolFilterFilterNodeByRelay
extends Node


signal on_filter_array_updated(filtered_array: Array[Node])

@export var filter_configuration:SensorToolResourceFilterNodeBy
@export var current_valide_nodes: Array[Node] 

func set_with_nodes_valide_not_recursive(nodes: Array[Node]):
	current_valide_nodes = []
	for node in nodes:
		if filter_configuration.is_node_valid_no_exploration(node):
			current_valide_nodes.append(node)

	on_filter_array_updated.emit(current_valide_nodes)


func set_with_nodes_valide_with_recursive_exploration(nodes: Array[Node]):
	current_valide_nodes = []
	for node in nodes:
		if filter_configuration.has_one_valid_node_with_exploration(node):
			current_valide_nodes.append(node)
	on_filter_array_updated.emit(current_valide_nodes)


func set_with_node_valide_not_recursive(node: Node):
	var solo_node_array := [node]
	set_with_nodes_valide_not_recursive(solo_node_array)

func set_with_node_valide_with_recursive_exploration(node: Node):
	var solo_node_array := [node]
	set_with_nodes_valide_with_recursive_exploration(solo_node_array)
