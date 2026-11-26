extends Node

@export var flash_time: float = 1.0
@export var flash_decay_time: float = 1.0
@export var flash_vfx: ColorRect
var flash_tween: Tween

signal on_flash

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			flash()

func flash() -> void:
	if flash_tween != null:
		flash_tween.stop()
	
	flash_tween = create_tween()
	flash_vfx.color = Color.WHITE
	flash_tween.tween_property(flash_vfx, "color", Color.TRANSPARENT, flash_decay_time).set_ease(Tween.EASE_IN).set_delay(flash_time)
	
	on_flash.emit()
