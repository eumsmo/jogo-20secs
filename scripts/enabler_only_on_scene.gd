class_name EnablerOnlyOnScene
extends Node

@export var scene: Scene
@export var is_enabled: bool = false

@export var interactables: Array[Interactable]
var _is_current_scene := false

func _ready() -> void:
	Game.instance.scenes.scene_changed.connect(scene_changed)
	check()

func scene_changed(current_scene: Scene):
	if current_scene == scene:
		_is_current_scene = true
		check()
	else:
		if _is_current_scene:
			check()
		_is_current_scene = false

func check():
	var is_it: bool = Game.instance.scenes.current_scene == scene and is_enabled
	
	for interactable in interactables:
		if interactable == null:
			continue
		
		if is_it:
			interactable.enable_interactable()
		else:
			interactable.disable_interactable()

func enable_interactable():
	is_enabled = true
	check()

func disable_interactable():
	is_enabled = false
	check()
