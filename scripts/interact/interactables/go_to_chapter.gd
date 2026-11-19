extends Interactable

@export var level: LevelInfo

func clicked():
	if level == null:
		return
	
	Game.instance.change_chapter(level)
	super()
