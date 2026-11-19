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
