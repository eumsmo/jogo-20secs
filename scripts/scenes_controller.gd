class_name ScenesController
extends Node

@export var current_scene: Scene
var fade: bool = false

func change_scene(scene: Scene):
	if current_scene == scene:
		return
	
	if fade:
		await UIManager.instance.shader.fade_to_black()
	else:
		await get_tree().physics_frame
	
	
	if current_scene != null:
		current_scene.deactivate()
	
	current_scene = scene
	current_scene.activate()
	
	if fade:
		await UIManager.instance.shader.fade_to_default()
	else:
		await get_tree().create_timer(0.1).timeout
