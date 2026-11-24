extends Node

@export var marker: ProgressMarker
@export var what: Control

func _ready() -> void:
	if ProgressManager.has_marker(marker):
		what.visible = true
	else:
		what.visible = false
	
