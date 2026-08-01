class_name SensorKS4036SubViewToTwoLinesPixel
extends SubViewport

signal on_top_left_color_updated(color: Color)
signal on_top_right_color_updated(color: Color)
signal on_top_left_right_color_updated(color_left: Color, color_right: Color)
signal on_texture_updated(texture:Texture2D)
@export var update_every_frame: bool = true
@export var color_difference_threshold: float = 0.001

@export var left_top_color: Color = Color.BLACK
@export var right_top_color: Color = Color.BLACK
@export var recovered_texture: Texture2D

func _process(_delta: float) -> void:
	if update_every_frame:
		refresh_colors()


func refresh_colors() -> void:
	# Wait until the viewport has rendered.
	await RenderingServer.frame_post_draw
	await get_tree().process_frame

	var texture := get_texture()
	if texture == null:
		return

	# Ensure texture is valid
	if texture.get_width() <= 0 or texture.get_height() <= 0:
		return

	recovered_texture = texture

	var image := texture.get_image()
	if image == null:
		return
	
	# Ensure image is valid before accessing pixels
	if image.is_empty():
		return

	var width := image.get_width()
	var height := image.get_height()

	if width <= 0 or height <= 0:
		return

	# If your image appears vertically flipped,
	# replace y = 0 with y = height - 1.
	var top_left := image.get_pixel(0, 0)
	var top_right := image.get_pixel(width - 1, 0)

	var left_changed := not colors_equal(top_left, left_top_color)
	var right_changed := not colors_equal(top_right, right_top_color)

	if left_changed:
		left_top_color = top_left
		on_top_left_color_updated.emit(left_top_color)

	if right_changed:
		right_top_color = top_right
		on_top_right_color_updated.emit(right_top_color)

	if left_changed or right_changed:
		on_top_left_right_color_updated.emit(left_top_color, right_top_color)
	on_texture_updated.emit(texture)


func colors_equal(a: Color, b: Color) -> bool:
	return (
		abs(a.r - b.r) < color_difference_threshold
		and abs(a.g - b.g) < color_difference_threshold
		and abs(a.b - b.b) < color_difference_threshold
		and abs(a.a - b.a) < color_difference_threshold
	)


func is_left_black(threshold: float = 0.05) -> bool:
	return is_color_black(left_top_color, threshold)


func is_right_black(threshold: float = 0.05) -> bool:
	return is_color_black(right_top_color, threshold)


func is_color_black(color: Color, threshold: float = 0.05) -> bool:
	return (
		color.r <= threshold
		and color.g <= threshold
		and color.b <= threshold
	)


func get_left_color() -> Color:
	return left_top_color


func get_right_color() -> Color:
	return right_top_color
