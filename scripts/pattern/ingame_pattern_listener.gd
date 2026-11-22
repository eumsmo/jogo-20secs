class_name InGamePatternListener
extends PatternListener

var current_target: Patterned
var target_locked: bool = false

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
	if current_target != target or current_target == null:
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
	elif Game.instance.scenes.current_scene != null:
		if Game.instance.scenes.current_scene.check_pattern(current_pattern):
			reset_pattern()
