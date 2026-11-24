extends Control

@export var previous_label: Button
@export var current_label: Label
@export var next_label: Button


@export var previous_progress_label: Label
@export var current_progress_label: Label
@export var next_progress_label: Label


@export var previous_button: TextureButton
@export var next_button: TextureButton


@export var listing: Control
@export var button: Control

var real_idx: int

signal chapter_selected(level: LevelInfo)

func _ready() -> void:
	await get_tree().process_frame
	
	var current = Game.current_level
	var ordered_list = ProgressManager.ordered_unlocked_chapters
	real_idx = ordered_list.find_custom(func(c): return c.idx == current.idx)
	
	show_button()
	update_labels(false)

func update_labels(call_signal := true):
	var ordered_list = ProgressManager.ordered_unlocked_chapters
	
	var current_level = ordered_list[real_idx]
	current_label.text = current_level.name
	
	if ProgressManager.showing_progress:
		current_progress_label.text = "({0}/{1})".format([current_level.achieved_progress_count, len(current_level.progress)])
		current_progress_label.visible = true
	else:
		current_progress_label.visible = false
	
	if (real_idx - 1) >= 0:
		var previous_level = ordered_list[real_idx-1]
		previous_label.text = previous_level.name
		previous_label.mouse_filter = Control.MOUSE_FILTER_PASS
		previous_button.visible = true
		previous_button.mouse_filter = Control.MOUSE_FILTER_PASS
		
		if ProgressManager.showing_progress:
			previous_progress_label.text = "({0}/{1})".format([previous_level.achieved_progress_count, len(previous_level.progress)])
			previous_progress_label.visible = true
		else:
			previous_progress_label.visible = false
	else:
		previous_label.text = ""
		previous_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		previous_button.visible = false
		previous_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
		previous_progress_label.visible = false
	
	if (real_idx + 1) < len(ordered_list):
		var next_level = ordered_list[real_idx+1]
		next_label.text = next_level.name
		next_label.mouse_filter = Control.MOUSE_FILTER_PASS
		next_button.visible = true
		next_button.mouse_filter = Control.MOUSE_FILTER_PASS
		
		if ProgressManager.showing_progress:
			next_progress_label.text = "({0}/{1})".format([next_level.achieved_progress_count, len(next_level.progress)])
			next_progress_label.visible = true
		else:
			next_progress_label.visible = false
	else:
		next_label.text = ""
		next_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		next_button.visible = false
		next_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
		next_progress_label.visible = false
	
	
	if call_signal:
		chapter_selected.emit(ordered_list[real_idx])

func previous():
	if real_idx - 1 >= 0:
		real_idx = real_idx - 1
		Game.previous_level = Game.current_level
	else:
		real_idx = 0
	
	update_labels()

func next():
	if real_idx + 1 < len(ProgressManager.unlocked_chapters):
		real_idx = real_idx + 1
		Game.previous_level = Game.current_level
	else:
		real_idx = len(ProgressManager.unlocked_chapters) - 1
	
	update_labels()

func show_listing():
	listing.show()
	listing.mouse_filter = Control.MOUSE_FILTER_PASS
	button.hide()
	button.mouse_filter = Control.MOUSE_FILTER_IGNORE

func show_button():
	if len(ProgressManager.unlocked_chapters) > 1 and Game.current_level.idx >= -2:
		button.show()
		button.mouse_filter = Control.MOUSE_FILTER_PASS
	else:
		button.hide()
		button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	listing.hide()
	listing.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_simple_pattern_listener_pattern_added(_dir: Game.Direction) -> void:
	show_button()
