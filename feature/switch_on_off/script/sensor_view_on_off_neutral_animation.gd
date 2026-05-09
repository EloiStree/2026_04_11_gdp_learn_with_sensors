class_name SensorViewOnOffNeutralAnimation
extends Node


@export var animation_on_name: String="ON"
@export var animation_off_name: String="OFF"
@export var animation_neutral_name: String="NEUTRAL"
@export var animation_player: AnimationPlayer


@export var use_at_ready: bool = true
@export var value_at_ready: bool = false


func _ready() -> void:
	if use_at_ready:
		set_animation_as_on_value(value_at_ready)


func set_animation_with_int_value(value: int) -> void:
	if value > 0:
		set_animation_as_on()
	elif value < 0:
		set_animation_as_off()
	else:
		set_animation_as_neutral()

func set_animation_with_float_value(value: float) -> void:
	if value > 0.00:
		set_animation_as_on()
	elif value < -0.00:
		set_animation_as_off()
	else:
		set_animation_as_neutral()

func set_animation_as_on_value(is_on: bool) -> void:
	if is_on:
		set_animation_as_on()
	else:
		set_animation_as_off()
		
func set_animation_as_neutral() -> void:
	if animation_neutral_name != "" and animation_player != null:
		if animation_player.has_animation(animation_neutral_name):
			animation_player.play(animation_neutral_name)


func set_animation_as_on() -> void:
		if animation_on_name != "" and animation_player != null:
			if animation_player.has_animation(animation_on_name):
				animation_player.play(animation_on_name)

func set_animation_as_off() -> void:
		if animation_off_name != "" and animation_player != null:
			if animation_player.has_animation(animation_off_name):
				animation_player.play(animation_off_name)
