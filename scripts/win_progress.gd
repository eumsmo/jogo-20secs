extends Node

@export var marker: ProgressMarker
signal progress_made

func progress():
	ProgressManager.add_marker(marker)
	progress_made.emit()
