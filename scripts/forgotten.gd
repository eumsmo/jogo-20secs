extends Node

@export var scene1: Scene
@export var scene2: Scene
@export var level: LevelInfo
var step: int = 0

func _ready() -> void:
	Game.instance.scenes.scene_changed.connect(_handle_scene_changed)

func _handle_scene_changed(scene: Scene):
	if scene != scene1 and scene != scene2:
		step = 0
		return
	
	if step > 4:
		try_to_change(step - 4)
		step += 1
	elif step % 2 == 0 and scene == scene1:
		step += 1
	elif step % 2 == 1 and scene == scene2:
		step += 1
	else:
		step = 0

func try_to_change(chances: int):
	var rand_value = randf()
	var reach = (pow(2, chances)/100)
	
	if reach > rand_value:
		change()

func change():
	Game.instance.change_chapter(level)
