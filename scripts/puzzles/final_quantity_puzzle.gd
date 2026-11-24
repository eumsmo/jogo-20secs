extends Node

@export var patterned: Patterned
@export var portraits: Array[PortraitPuzzle]

@export var convertion: Dictionary[Game.Direction, String]

func _ready() -> void:
	generate_pattern()

func generate_pattern():
	var pattern: Array[Game.Direction] = [Game.Direction.UP,Game.Direction.RIGHT,Game.Direction.DOWN,Game.Direction.LEFT]
	pattern.shuffle()
	
	patterned.pattern = pattern
	print("QUANTITY: ", pattern.map(func(x): return Game.Direction.find_key(x)))
	
	var distribution: Array[String]
	
	for i in range(0,len(pattern)):
		for j in range(0, i+1):
			distribution.append(convertion[pattern[i]])
	
	distribution.shuffle()
	
	for i in range(0, len(distribution)):
		portraits[i].set_label(distribution[i])
