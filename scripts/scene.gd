class_name Scene
extends Node3D

@export var camera: Camera3D
@export var on_scene_only: Array[Node3D]

func activate():
	camera.make_current()
	
	for obj in on_scene_only:
		obj.visible = true

func deactivate():
	for obj in on_scene_only:
		obj.visible = false
