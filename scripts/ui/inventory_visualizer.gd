extends Control

@export var image_scene: PackedScene
var inventory_relation: Dictionary[Item, Control]

func _ready() -> void:
	Game.instance.inventory.item_added.connect(on_added)
	Game.instance.inventory.item_removed.connect(on_removed)

func on_added(item: Item):
	var instance: TextureRect = image_scene.instantiate()
	instance.texture = item.sprite
	inventory_relation[item] = instance
	
	add_child(instance)

func on_removed(item: Item):
	if inventory_relation.has(item):
		inventory_relation[item].queue_free()
		inventory_relation.erase(item)
