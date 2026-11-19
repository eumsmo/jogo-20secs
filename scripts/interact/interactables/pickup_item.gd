class_name PickupItem
extends Interactable

@export var item: Item
@export var remove_node: Node3D

func clicked() -> bool:
	if item == null:
		return false
	
	Game.instance.inventory.add(item)
	remove_node.queue_free()
	
	return super()
