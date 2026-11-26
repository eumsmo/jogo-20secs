extends Interactable

@export var chapter_id: int
@export var progress_marker: ProgressMarker

func clicked() -> bool:
	if progress_marker != null:
		ProgressManager.add_marker(progress_marker)
	
	var level = Game.instance.get_chapter_by_id(chapter_id)
	Game.instance.change_chapter(level)
	return super()
