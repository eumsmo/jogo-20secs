class_name Interactable
extends Area3D

signal on_clicked
signal on_hover
signal on_unhover

func _ready() -> void:
	input_event.connect(click_handle)
	mouse_entered.connect(hovered)
	mouse_exited.connect(unhovered)

func click_handle(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_pressed():
			clicked()

func clicked():
	on_clicked.emit()

func hovered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	on_hover.emit()

func unhovered():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	on_unhover.emit()
