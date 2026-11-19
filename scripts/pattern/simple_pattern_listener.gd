class_name SimplePatternListener
extends PatternListener

@export var target_pattern: Array[Game.Direction]
signal on_correct

func check_pattern():
	if len(current_pattern) < len(target_pattern):
		return
	
	for i in range(0, len(target_pattern)):
		if current_pattern[i] != target_pattern[i]:
			return
	
	on_correct.emit()
	reset_pattern()
