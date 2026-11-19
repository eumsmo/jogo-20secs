extends Node

@export var starts_on: bool = false

@export var mesh: MeshInstance3D
@export var material_idx: int = 0

@export var on_material: Material
@export var off_material: Material

@export var lights: Array[Node3D]

func _ready() -> void:
	if starts_on:
		set_on()
	else:
		set_off()

func set_on():
	mesh.set_surface_override_material(material_idx, on_material)
	
	for light in lights:
		light.visible = true

func set_off():
	mesh.set_surface_override_material(material_idx, off_material)
	
	for light in lights:
		light.visible = false
