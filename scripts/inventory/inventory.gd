class_name Inventory
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

var inventory: Array[Item]

func add(item: Item):
	inventory.append(item)
	item_added.emit(item)

func remove(item: Item):
	var idx = inventory.find(item)
	
	if idx >= 0:
		inventory.remove_at(idx)
		item_removed.emit(item)

func has(item: Item) -> bool:
	return inventory.has(item)
