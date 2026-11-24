extends Node


@export var patterned: Patterned

@export var pointers: Array[Node3D]

@export var rotation_relation: Dictionary[Game.Direction, int]

func _ready() -> void:
	generate_pattern()

func generate_pattern():
	var pattern: Array[Game.Direction] = [
		Game.Direction.UP,Game.Direction.RIGHT,Game.Direction.DOWN,Game.Direction.LEFT,
		Game.Direction.UP_LEFT, Game.Direction.UP_RIGHT, Game.Direction.DOWN_LEFT, Game.Direction.DOWN_RIGHT
	]
	pattern.shuffle()
	pattern = pattern.slice(0, 3)
	
	patterned.pattern = pattern
	print("CLOCK: ", pattern.map(func(x): return Game.Direction.find_key(x)))
	
	for i in range(0, len(pattern)):
		var rot = rotation_relation[pattern[i]]
		pointers[i].rotation_degrees.x = rot
