class_name Wire
extends Node

@export var areas: Array[WireArea3D]
var connected_wires: Array[Wire]

var charges: Dictionary[WireCharge, int]

@export var mesh: MeshInstance3D
@export var receiving_material: Material

signal charge_change(wire: Wire, value: int)

func _ready() -> void:
	for area in areas:
		area.wire = self
		area.area_entered.connect(connected_area)
		area.area_exited.connect(disconnected_area)
	
		for overlap in area.get_overlapping_areas():
			connected_area(overlap)

func refresh_connected_areas():
	for area in areas:
		for overlap in area.get_overlapping_areas():
			connected_area(overlap)

func connected_area(area: Area3D):
	if area is WireArea3D:
		if not connected_wires.has(area.wire):
			connected_wires.append(area.wire)

func disconnected_area(area: Area3D):
	if area is WireArea3D:
		if connected_wires.has(area.wire):
			connected_wires.erase(area.wire)

func receive(charge: WireCharge, current_value: int):
	if charge.has_wire(self):
		return
	
	charges[charge] = current_value + 1
	charge.add_wire(self)
	charge.on_reset.connect(reset_charge)
	
	for wire in connected_wires:
		wire.receive(charge, charges[charge])
	
	update_visual()

func reset_charge(charge: WireCharge):
	charges.erase(charge)
	charge.remove_wire(self)
	charge.on_reset.disconnect(reset_charge)
	
	update_visual()

func update_visual():
	if charges.size() == 0:
		mesh.material_override = null
	else:
		mesh.material_override = receiving_material
