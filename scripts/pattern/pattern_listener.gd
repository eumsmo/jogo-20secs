@abstract
class_name PatternListener
extends Node

@export var clear_timer: Timer

var current_pattern: Array[Game.Direction]
signal pattern_cleared
signal pattern_added(dir: Game.Direction)

func _ready() -> void:
	clear_timer.timeout.connect(reset_pattern)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		add_to_pattern(Game.Direction.UP)
	elif event.is_action_pressed("left"):
		add_to_pattern(Game.Direction.LEFT)
	elif event.is_action_pressed("down"):
		add_to_pattern(Game.Direction.DOWN)
	elif event.is_action_pressed("right"):
		add_to_pattern(Game.Direction.RIGHT)

func add_to_pattern(dir: Game.Direction):
	current_pattern.append(dir)
	pattern_added.emit(dir)
	clear_timer.start()
	check_pattern()

func reset_pattern():
	current_pattern.clear()
	pattern_cleared.emit()
	clear_timer.stop()

@abstract func check_pattern()

static func is_direction_composite(dir: Game.Direction) -> bool:
	return dir == Game.Direction.UP_LEFT or dir == Game.Direction.UP_RIGHT or dir == Game.Direction.DOWN_LEFT or dir == Game.Direction.DOWN_RIGHT

static func get_composite_dir(dir1: Game.Direction, dir2: Game.Direction) -> Game.Direction:
	var is_up = null
	var is_left = null
	
	if dir1 == Game.Direction.UP or dir2 == Game.Direction.UP:
		is_up = true
	elif dir1 == Game.Direction.DOWN or dir2 == Game.Direction.DOWN:
		is_up = false
	
	if dir1 == Game.Direction.LEFT or dir2 == Game.Direction.LEFT:
		is_left = true
	elif dir1 == Game.Direction.RIGHT or dir2 == Game.Direction.RIGHT:
		is_left = false
	
	if is_up == null or is_left == null:
		return dir1
	
	if is_up:
		if is_left:
			return Game.Direction.UP_LEFT
		else:
			return Game.Direction.UP_RIGHT
	else:
		if is_left:
			return Game.Direction.DOWN_LEFT
		else:
			return Game.Direction.DOWN_RIGHT

static func pattern_size_parsed(pattern: Array[Game.Direction]) -> int:
	var c = 0
	
	for dir in pattern:
		if is_direction_composite(dir):
			c += 2
		else:
			c += 1
	
	return c

static func compare_pattern(checking: Array[Game.Direction], correct: Array[Game.Direction]) -> bool:
	if len(checking) != pattern_size_parsed(correct):
		return false
	
	var i = 0
	for current_correct in correct:
		var is_composite = is_direction_composite(current_correct)
		var current_check = checking[i]
		
		if is_composite:
			i += 1
			var next_check = checking[i]
			current_check = get_composite_dir(current_check, next_check)
		
		if current_correct != current_check:
			return false
			
		i += 1
	
	return true
