@tool
extends Node

@export_category("Debug")
@export var click_to_reparent: bool:
	set(value):
		reparent_child()
		print(value)

func reparent_child():
	var parents: Dictionary[Node, Node3D]
	
	for child in get_children():
		var new_parent = Node3D.new()
		
		parents[child] = new_parent
		add_child(new_parent)
		new_parent.owner = child.owner
		
		new_parent.global_position = child.global_position
		new_parent.global_rotation = child.global_rotation
	
	await get_tree().create_timer(0.5)
	
	for child in parents:
		child.reparent(parents[child])
		parents[child].name = child.name
