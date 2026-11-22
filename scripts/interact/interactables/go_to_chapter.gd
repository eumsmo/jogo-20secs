extends Interactable

@export var level: LevelInfo
@export var progress_marker: ProgressMarker

func clicked() -> bool:
	if level == null:
		return false
	
	if progress_marker != null:
		ProgressManager.add_marker(progress_marker)
	
	Game.instance.change_chapter(level)
	return super()
