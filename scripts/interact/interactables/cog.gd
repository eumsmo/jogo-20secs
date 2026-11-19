class_name Cog
extends Interactable

@export var to_rotate: Node3D
@export_range(0, 360, 0.1, "radians_as_degrees") var rotate_by: float

func clicked() -> bool:
	to_rotate.rotate_z(rotate_by)
	
	return super()
