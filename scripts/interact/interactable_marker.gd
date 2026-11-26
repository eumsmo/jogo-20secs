extends Node3D

@export var duration_time: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(duration_time).timeout
	queue_free()
