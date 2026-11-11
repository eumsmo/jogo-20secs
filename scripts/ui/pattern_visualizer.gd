extends Control

@export_group("Prefabs")
@export var up_arrow: PackedScene
@export var left_arrow: PackedScene
@export var down_arrow: PackedScene
@export var right_arrow: PackedScene

func _ready() -> void:
	Game.instance.pattern.pattern_added.connect(on_added)
	Game.instance.pattern.pattern_cleared.connect(on_reset)

func get_arrow_scene(dir: Game.Direction) -> PackedScene:
	match dir:
		Game.Direction.UP:
			return up_arrow
		Game.Direction.LEFT:
			return left_arrow
		Game.Direction.DOWN:
			return down_arrow
		Game.Direction.RIGHT:
			return right_arrow
	return up_arrow

func on_added(dir: Game.Direction):
	var scene = get_arrow_scene(dir)
	var instance = scene.instantiate()
	
	add_child(instance)

func on_reset():
	for child in get_children():
		child.queue_free()
