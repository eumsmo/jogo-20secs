class_name Scene
extends Node3D

@export var camera: Camera3D
@export var on_scene_only: Array[Node3D]
@export var scene_patterns: Array[ScenePattern]

func activate():
	camera.make_current()
	
	for obj in on_scene_only:
		obj.visible = true

func deactivate():
	for obj in on_scene_only:
		obj.visible = false

func check_pattern(pattern: Array[Game.Direction]) -> bool:
	var got_it: ScenePattern = null
	
	for patterns in scene_patterns:
		if patterns.check_pattern(pattern):
			got_it = patterns
			break
	
	if got_it != null:
		if got_it.only_once:
			scene_patterns.erase(got_it)
	
	return got_it != null
