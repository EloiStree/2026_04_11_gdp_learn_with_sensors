class_name SensorToolQuickFollowIt
extends Node


@export var what_to_move:Node3D
@export var what_to_follow:Node3D

@export var use_rotation: bool = true
@export var use_position: bool = true

func _process(delta: float) -> void:
	if not what_to_move or not what_to_follow:
		return
	if use_position:
		what_to_move.global_position = what_to_follow.global_position
	if use_rotation:
		what_to_move.global_rotation = what_to_follow.global_rotation




