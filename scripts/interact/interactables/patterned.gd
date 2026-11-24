class_name Patterned
extends Interactable

@export var pattern: Array[Game.Direction]
@export var mesh: MeshInstance3D
@export var material_idx: Array[int] = [0]
@export var selected_material: Material
@export var locked_material: Material
@export var active_on_selected: Array[Node3D]
@export var only_in_order := true


signal on_pattern_made

var locked := false

func _ready() -> void:
	super()
	
	if locked_material == null:
		locked_material = selected_material
	
	on_untarget()

func clicked() -> bool:
	locked = !locked
	Game.instance.pattern.set_target(self, locked)
	return super()

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
		for idx in material_idx:
			mesh.set_surface_override_material(idx, selected_material if not locked else locked_material)
		#mesh.material_override = selected_material if not locked else locked_material
	
	for obj in active_on_selected:
		obj.visible = true

func on_untarget():
	for idx in material_idx:
		mesh.set_surface_override_material(idx, null)
	#mesh.material_override = null
	locked = false
	
	for obj in active_on_selected:
		obj.visible = false

func check_pattern(pattern_to_check: Array[Game.Direction]) -> bool:
	if only_in_order:
		return PatternListener.compare_pattern(pattern_to_check, pattern)
	else:
		return PatternListener.unordered_compare(pattern_to_check, pattern)

func activate_pattern():
	on_pattern_made.emit()
	locked = false

func disable_interactable():
	super()
	Game.instance.pattern.clear_target(self)
