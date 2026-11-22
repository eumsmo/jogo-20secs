class_name Cog
extends Interactable

@export var to_rotate: Node3D
@export_range(0, 360, 0.1, "radians_as_degrees") var rotate_by: float

@export var direction_array: Array[Game.Direction]
@export var current_direction_idx: int = 0
var current_direction: Game.Direction:
	get:
		return direction_array[current_direction_idx]

@export var rotate_x := false
@export var rotate_y := false
@export var rotate_z := true


func clicked() -> bool:
	if rotate_x:
		to_rotate.rotate_x(rotate_by)
	if rotate_y:
		to_rotate.rotate_y(rotate_by)
	if rotate_z:
		to_rotate.rotate_z(rotate_by)
	
	if len(direction_array) > 0:
		next_directon()
	
	return super()

func next_directon():
	current_direction_idx = (current_direction_idx + 1) % len(direction_array)
