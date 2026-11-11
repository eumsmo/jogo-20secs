class_name Patterned
extends Interactable

@export var pattern: Array[Game.Direction]
@export var mesh: MeshInstance3D
var default_material: Material
@export var selected_material: Material
@export var locked_material: Material
@export var active_on_selected: Array[Node3D]


signal on_pattern_made

var locked := false

func _ready() -> void:
	super()
	default_material = mesh.get_active_material(0)
	
	if locked_material == null:
		locked_material = selected_material
	
	on_untarget()

func clicked():
	locked = !locked
	Game.instance.pattern.set_target(self, locked)
	super()

func hovered():
	Game.instance.pattern.set_target(self, locked)
	super()

func unhovered():
	if locked:
		super()
		return
	
	Game.instance.pattern.clear_target(self)
	super()

func on_target():
	if selected_material != null:
		mesh.material_override = selected_material if not locked else locked_material
	
	for obj in active_on_selected:
		obj.visible = true

func on_untarget():
	mesh.material_override = null
	locked = false
	
	for obj in active_on_selected:
		obj.visible = false

func check_pattern(pattern_to_check: Array[Game.Direction]) -> bool:
	if len(pattern_to_check) < len(pattern):
		return false
	
	for i in range(0, len(pattern)):
		if pattern_to_check[i] != pattern[i]:
			return false
	
	return true

func activate_pattern():
	on_pattern_made.emit()
	locked = false
