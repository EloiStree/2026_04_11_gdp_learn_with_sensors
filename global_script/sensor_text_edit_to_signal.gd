class_name SensorTextEditToSignal
extends Node

signal  on_text_changed(text:String)
signal  on_text_set(text:String)

@export var text_edit_to_observed:TextEdit


func _ready() -> void:
	text_edit_to_observed.text_changed.connect(notify_text_changed)
	text_edit_to_observed.text_set.connect(notify_text_set)

func notify_text_changed():
	on_text_changed.emit(text_edit_to_observed.text)

func notify_text_set():
	on_text_set.emit(text_edit_to_observed.text)
