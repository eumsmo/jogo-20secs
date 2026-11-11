class_name Game
extends Node

static var instance: Game

@export_group("Controllers")
@export var scenes: ScenesController
@export var pattern: PatternListener
@export var inventory: Inventory

enum Direction { UP, LEFT, DOWN, RIGHT }

func _init() -> void:
	if instance != null:
		queue_free()
		return
	
	instance = self
