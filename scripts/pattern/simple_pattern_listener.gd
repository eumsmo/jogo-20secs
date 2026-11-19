class_name SimplePatternListener
extends PatternListener

@export var target_pattern: Array[Game.Direction]
signal on_correct

func check_pattern():
	if not PatternListener.compare_pattern(current_pattern, target_pattern):
		return
	
	on_correct.emit()
	reset_pattern()
