class_name PatternListener
extends Node

@export var clear_timer: Timer

var current_target: Patterned
var target_locked: bool = false

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

func set_target(target: Patterned, locked:= false):
	if target == current_target:
		target_locked = locked
		current_target.on_target()
		return
	
	if target_locked and not locked:
		return
	
	if current_target != null:
		current_target.on_untarget()
	
	target_locked = locked
	reset_pattern()
	current_target = target
	current_target.on_target()

func clear_target(target: Patterned):
	if current_target != target:
		return
	
	reset_pattern()
	current_target.on_untarget()
	current_target = null

func check_pattern():
	if current_target != null:
		if current_target.check_pattern(current_pattern):
			current_target.activate_pattern()
			target_locked = false
			clear_target(current_target)
