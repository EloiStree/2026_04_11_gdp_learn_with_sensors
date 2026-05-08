class_name SensorKS4036ResetScale1
extends Node

@export var target_node=Node3D

func _ready() -> void:
	target_node.scale = Vector3.ONE
