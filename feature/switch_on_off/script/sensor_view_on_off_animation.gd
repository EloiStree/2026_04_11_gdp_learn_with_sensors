class_name SensorViewOnOffAnimation
extends Node


@export var animation_on_name: String="ON"
@export var animation_off_name: String="OFF"
@export var animation_player: AnimationPlayer


@export var use_at_ready: bool = true
@export var value_at_ready: bool = false


func _ready() -> void:
	if use_at_ready:
		set_animation_as_on_value(value_at_ready)

func set_animation_as_on_value(is_on: bool) -> void:
	if is_on:
		if animation_on_name != "" and animation_player != null:
			if animation_player.has_animation(animation_on_name):
				animation_player.play(animation_on_name)
	else:
		if animation_off_name != "" and animation_player != null:
			if animation_player.has_animation(animation_off_name):
				animation_player.play(animation_off_name)
