class_name ChangeSceneInteractable
extends Interactable

@export var scene: Scene

func clicked() -> bool:
	if scene == null:
		return false
	
	Game.instance.scenes.change_scene(scene)
	return super()
