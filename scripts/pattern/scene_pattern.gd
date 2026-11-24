class_name ScenePattern
extends Node

@export var pattern: Array[Game.Direction]
@export var only_in_order := true
@export var only_once := true
signal on_pattern_made

func check_pattern(pattern_to_check: Array[Game.Direction]) -> bool:
	if only_in_order:
		if not PatternListener.compare_pattern(pattern_to_check, pattern):
			return false
	else:
		if not PatternListener.unordered_compare(pattern_to_check, pattern):
			return false
	
	on_pattern_made.emit()
	return true
