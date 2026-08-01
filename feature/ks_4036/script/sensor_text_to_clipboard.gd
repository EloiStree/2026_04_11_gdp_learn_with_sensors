class_name SensorTextToClipboard
extends Node


@export_multiline()
var _text_to_copy_when_requested:String

func copy_text_to_clipboard(text:String) -> void:
	DisplayServer.clipboard_set(text)

func copy_text_to_clipboard_from_inspector() -> void:
	copy_text_to_clipboard(_text_to_copy_when_requested)

func set_text_to_copy_when_requested(new_value:String) -> void:
	_text_to_copy_when_requested = new_value
