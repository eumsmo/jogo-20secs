class_name Counter
extends Node

@export var current: int = 0
@export var target: int = 0

enum WhenTargeted { ONE_TIME_ONLY, RESTART }
@export var when_targeted: WhenTargeted = WhenTargeted.ONE_TIME_ONLY

@export var remove_item_on_target: Item

signal on_target

var hitted := false

func increment_one():
	if hitted and when_targeted == WhenTargeted.ONE_TIME_ONLY:
		return
	
	current += 1
	check_value()

func increment(value: int):
	if hitted and when_targeted == WhenTargeted.ONE_TIME_ONLY:
		return
	
	current += value
	check_value()

func check_value():
	if current < target:
		return
	
	on_target.emit()
	
	if remove_item_on_target != null:
		Game.instance.inventory.remove(remove_item_on_target)

	hitted = true
	if when_targeted == WhenTargeted.RESTART:
		current = 0
