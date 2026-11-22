extends Node

@export var pattern: Array[Game.Direction]
@export var cogs: Array[Cog]

signal on_pattern_reached

func _ready() -> void:
	for cog in cogs:
		cog.on_clicked.connect(check)

func check() -> bool:
	for i in range(0, len(cogs)):
		if cogs[i].current_direction != pattern[i]:
			return false
	
	on_pattern_reached.emit()
	return true
