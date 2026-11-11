class_name UseItemInteractable
extends Interactable

@export var item: Item
@export var remove_item: bool = true

@export var delete_nodes: Array[Node3D]
signal item_used

func _ready() -> void:
	super()
	auto_change_cursor = false

func clicked():
	if not Game.instance.inventory.has(item):
		return
	
	if remove_item:
		Game.instance.inventory.remove(item)
	
	for obj in delete_nodes:
		obj.queue_free()
	
	item_used.emit()

	super()


func hovered():
	if Game.instance.inventory.has(item):
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	super()

func unhovered():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	super()
