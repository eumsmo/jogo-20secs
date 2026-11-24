class_name ProgressManager
extends Node

static var progress_markers: Array[ProgressMarker]
static var showing_progress: bool = false

static var unlocked_chapters: Array[LevelInfo]
static var ordered_unlocked_chapters: Array[LevelInfo]:
	get:
		var sorted = unlocked_chapters.duplicate()
		sorted.sort_custom(func(c,d): return c.idx < d.idx)
		return sorted

static func unlock_chapter(level: LevelInfo):
	if not level.show_in_list:
		return
	
	if not unlocked_chapters.has(level):
		unlocked_chapters.append(level)

static func has_marker(marker: ProgressMarker) -> bool:
	return progress_markers.has(marker)

static func add_marker(marker: ProgressMarker):
	if not progress_markers.has(marker):
		progress_markers.append(marker)

static func count_markers_achieved(level: LevelInfo) -> int:
	var c = 0
	for marker in level.progress:
		if has_marker(marker):
			c += 1
	
	return c
