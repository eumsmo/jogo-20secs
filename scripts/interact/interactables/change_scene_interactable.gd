class_name ChangeSceneInteractable
extends Interactable

@export var scene: Scene

func clicked():
	if scene == null:
		return
	
	Game.instance.scenes.change_scene(scene)
	super()
