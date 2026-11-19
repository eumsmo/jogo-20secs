extends Interactable

@export var level: LevelInfo

func clicked() -> bool:
	if level == null:
		return false
	
	Game.instance.change_chapter(level)
	return super()
