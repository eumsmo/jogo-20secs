class_name MultipleInteractable
extends Interactable

@export var interactables: Array[Interactable]

func clicked() -> bool:
	for interactable in interactables:
		if interactable.clicked():
			return true
	
	return super()

func can_interact() -> bool:
	for interactable in interactables:
		if interactable.can_interact():
			return true
	
	return false
