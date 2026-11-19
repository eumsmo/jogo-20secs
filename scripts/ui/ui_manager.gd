class_name UIManager
extends Control

static var instance: UIManager

@export var shader: ShaderController
@export var intro: IntroManager

func _init() -> void:
	instance = self
