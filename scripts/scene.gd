class_name Scene
extends Node3D

@export var camera: Camera3D
@export var on_scene_only: Array[Node3D]
@export var scene_patterns: Array[ScenePattern]
@export var child_of: Scene = null

signal on_activated
signal on_deactivated

func activate():
	camera.make_current()
	
	for obj in on_scene_only:
		if obj == null:
			continue
		
		obj.visible = true
		if obj is Area3D:
			obj.input_ray_pickable = true
	
	on_activated.emit()

func deactivate():
	for obj in on_scene_only:
		if obj == null:
			continue
		
		obj.visible = false
		if obj is Area3D:
			obj.input_ray_pickable = false
	
	on_deactivated.emit()

func check_pattern(pattern: Array[Game.Direction]) -> bool:
	var got_it: ScenePattern = null
	var one_is_null = false
	
	for patterns in scene_patterns:
		if patterns == null:
			one_is_null = true
			continue
		if patterns.check_pattern(pattern):
			got_it = patterns
			break
	
	if got_it != null:
		if got_it.only_once:
			scene_patterns.erase(got_it)
	
	if one_is_null:
		scene_patterns.erase(null)
	
	return got_it != null
