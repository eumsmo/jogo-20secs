class_name WireChargeReceiver
extends Wire

signal on_receive
signal on_lost_signal

func receive(charge: WireCharge, current_value: int):
	if charge.has_wire(self):
		return
	
	super(charge, current_value)
	
	on_receive.emit()

func reset_charge(charge: WireCharge):
	super(charge)
	
	on_lost_signal.emit()
