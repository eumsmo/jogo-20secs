class_name PickupItem
extends Interactable

@export var item: Item
@export var remove_node: Node3D

func clicked():
	if item == null:
		return
	
	Game.instance.inventory.add(item)
	remove_node.queue_free()
	
	super()
