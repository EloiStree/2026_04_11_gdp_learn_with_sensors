class_name SensorDefaultDeveloperNote
extends Node

@export_multiline var developer_note: String = "This is a developer note."

func get_note_as_text() -> String:
	return developer_note

func set_note_as_text(new_note: String) -> void:
	developer_note = new_note
