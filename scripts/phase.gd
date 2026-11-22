class_name Phase
extends Node3D

@export var starting_scene: Scene

func set_disabled():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
