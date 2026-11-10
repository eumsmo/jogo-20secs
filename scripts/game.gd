class_name Game
extends Node

static var instance: Game

@export_group("Controllers")
@export var scenes: ScenesController

func _init() -> void:
	if instance != null:
		queue_free()
		return
	
	instance = self
