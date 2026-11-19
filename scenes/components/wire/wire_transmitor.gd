class_name WireChargeEmissor
extends Wire

var charge: WireCharge

func _ready() -> void:
	super()
	await get_tree().create_timer(0.2).timeout
	call_to_reset()

func transmit():
	var id = 1
	
	if charge != null:
		id = charge.id + 1
		charge.reset()
	
	charge = WireCharge.new()
	charge.emissor = self
	charge.id = id
	
	for wire in connected_wires:
		wire.receive(charge, 0)

func call_to_reset():
	for i in range(0,5):
		await get_tree().process_frame
	
	transmit()

func update_visual():
	mesh.material_override = receiving_material
