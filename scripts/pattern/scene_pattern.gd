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
		var got_it_once = false
		var tam = len(pattern)
		for i in range(0, tam):
			var pattern_version = pattern.slice(i, tam)
			pattern_version.append_array(pattern.slice(0, i))
			if PatternListener.compare_pattern(pattern_to_check, pattern_version):
				got_it_once = true
		if not got_it_once:
			return false
	
	on_pattern_made.emit()
	return true
