class_name ScenesController
extends Node

@export var current_scene: Scene

func change_scene(scene: Scene):
	if current_scene == scene:
		return
	
	await UIManager.instance.shader.fade_to_black()
	
	if current_scene != null:
		current_scene.deactivate()
	
	current_scene = scene
	current_scene.activate()
	
	print(scene.name)
	
	await UIManager.instance.shader.fade_to_default()
