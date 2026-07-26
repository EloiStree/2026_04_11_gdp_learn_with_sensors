class_name SensorKS4036SubViewToTwoLinesPixel
extends Node

signal on_top_left_color_updated(color: Color)
signal on_top_right_color_updated(color: Color)
signal on_top_left_right_color_updated(color_left: Color, color_right: Color)


@export var _subView: SubViewport
@export var _left_top_color: Color = Color.BLACK
@export var _right_top_color: Color = Color.BLACK
@export var _recovered_texture: Texture2D

@export var _update_fixed_process: bool = true

func _physics_process(delta: float) -> void:
	if _update_fixed_process:
		refresh_color_from_subView()

func refresh_color_from_subView() -> void:
	if _subView == null:
		return

	var texture := _subView.get_texture()
	if texture == null:
		return

	_recovered_texture = texture

	var image := texture.get_image()
	if image == null:
		return

	# If using Godot 4, locking isn't required, but harmless if omitted.
	var width := image.get_width()

	if width < 16:
		return

	var top_left := image.get_pixel(0, 0)
	var top_right := image.get_pixel(15, 0)

	var left_changed := top_left != _left_top_color
	var right_changed := top_right != _right_top_color

	if left_changed:
		_left_top_color = top_left
		on_top_left_color_updated.emit(top_left)

	if right_changed:
		_right_top_color = top_right
		on_top_right_color_updated.emit(top_right)

	if left_changed or right_changed:
		on_top_left_right_color_updated.emit(_left_top_color, _right_top_color)


func is_left_black(threshold: float) -> bool:
	return is_color_black(_left_top_color, threshold)

func is_right_black(threshold: float) -> bool:
	return is_color_black(_right_top_color, threshold)

func is_color_black(color: Color, threshold: float) -> bool:
	var brightness := color.r * 0.299 + color.g * 0.587 + color.b * 0.114
	return brightness < threshold
