extends Node

@export var label: Label

func _ready() -> void:
	if not ProgressManager.showing_progress:
		label.visible = false
		return
	
	var markers: Array[ProgressMarker]
	for level: LevelInfo in Game.instance.level_scene_relation.keys():
		markers.append_array(level.progress)
	
	var count = len(markers)
	var having = ProgressManager.progress_markers.filter(func(m): return markers.has(m)).size()
	
	label.text = str(floori(100 * having / count)) + "%"
	label.visible = true
