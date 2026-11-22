class_name LevelInfo
extends Resource

@export var idx: int
@export var chapter: String
@export var name: String
@export var pattern: Array[Game.Direction]

@export var palette: CompressedTexture2D

@export var show_in_list: bool = true

@export var progress: Array[ProgressMarker]
var achieved_progress_count: int:
	get:
		return ProgressManager.count_markers_achieved(self)
