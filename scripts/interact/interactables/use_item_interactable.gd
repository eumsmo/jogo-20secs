class_name UseItemInteractable
extends Interactable

@export var item: Item
@export var remove_item: bool = true

@export var delete_nodes: Array[Node3D]
signal item_used

func clicked() -> bool:
	if not Game.instance.inventory.has(item):
		return false
	
	if remove_item:
		Game.instance.inventory.remove(item)
	
	for obj in delete_nodes:
		obj.queue_free()
	
	item_used.emit()

	return super()

func can_interact() -> bool:
	return Game.instance.inventory.has(item)
