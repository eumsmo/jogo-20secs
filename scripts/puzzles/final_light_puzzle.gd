extends Node


@export var patterned: Patterned
@export var scene_pattern: ScenePattern
@export var light_pattern: LightPattern

@export var indicator: Dictionary[Game.Direction, Node3D]

@export var pattern_blinks_up: Dictionary[Game.Direction, int]
@export var pattern_blinks_left: Dictionary[Game.Direction, int]
@export var pattern_blinks_down: Dictionary[Game.Direction, int]
@export var pattern_blinks_right: Dictionary[Game.Direction, int]

func _ready() -> void:
	generate_pattern()

func generate_pattern():
	var pattern: Array[Game.Direction] = [
		Game.Direction.UP,Game.Direction.RIGHT,Game.Direction.DOWN,Game.Direction.LEFT,
		#Game.Direction.UP,Game.Direction.RIGHT,Game.Direction.DOWN,Game.Direction.LEFT,
	]
	pattern.shuffle()
	pattern = pattern.slice(0, 3)
	
	patterned.pattern = pattern
	scene_pattern.pattern = pattern
	#print("LIGHT: ", pattern.map(func(x): return Game.Direction.find_key(x)))
	
	var distribution: Array[String]
	
	var base: Array[Game.Direction] = [ Game.Direction.UP,Game.Direction.RIGHT,Game.Direction.DOWN,Game.Direction.LEFT ]
	var dir: Game.Direction = base.pick_random()
	
	
	light_pattern.pattern = pattern
	match dir:
		Game.Direction.UP:
			light_pattern.pattern_blinks = pattern_blinks_up
		Game.Direction.LEFT:
			light_pattern.pattern_blinks = pattern_blinks_left
		Game.Direction.DOWN:
			light_pattern.pattern_blinks = pattern_blinks_down
		Game.Direction.RIGHT:
			light_pattern.pattern_blinks = pattern_blinks_right
	
	for key in indicator.keys():
		indicator[key].visible = (key == dir)
	
	light_pattern.start_pattern()
