extends Node

@export var marker: ProgressMarker

func progress():
	ProgressManager.add_marker(marker)
