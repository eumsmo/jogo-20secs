class_name UIManager
extends Control

static var instance: UIManager

@export var shader: ShaderController

func _init() -> void:
	if instance != null:
		queue_free()
		return
	
	instance = self
