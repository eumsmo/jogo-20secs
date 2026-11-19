class_name WireCharge

var id: int
var emissor: WireChargeEmissor

signal on_reset(charge: WireCharge)

var charged_wires: Array[Wire]

func add_wire(wire: Wire):
	charged_wires.append(wire)

func remove_wire(wire: Wire):
	charged_wires.erase(wire)

func has_wire(wire: Wire) -> bool:
	return charged_wires.has(wire)

func reset():
	on_reset.emit(self)
