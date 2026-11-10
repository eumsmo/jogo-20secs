class_name ShaderController
extends Node


@export var shaded_canvas: Control
var shaded_material: ShaderMaterial

@export_group("Fade Configs")
@export var fade_black_time := 0.5
@export var fade_default_time := 0.5

signal faded_to_black
signal faded_to_default

func _ready() -> void:
	shaded_material = shaded_canvas.material.duplicate()
	shaded_canvas.material = shaded_material

func fade_to_black() -> void:
	var timer = get_tree().create_timer(fade_black_time)
	
	while timer.time_left > 0:
		var progress = 1 - timer.time_left / fade_black_time
		shaded_material.set_shader_parameter("u_offset", -progress/2)
		await get_tree().physics_frame
		
	shaded_material.set_shader_parameter("u_offset", -0.5)
	faded_to_black.emit()

func fade_to_default() -> void:
	var timer = get_tree().create_timer(fade_default_time)
	
	while timer.time_left > 0:
		var progress = timer.time_left / fade_default_time
		shaded_material.set_shader_parameter("u_offset", -progress/2)
		await get_tree().physics_frame
		
	shaded_material.set_shader_parameter("u_offset", 0.0)
	faded_to_default.emit()

func fade_inout_black() -> void:
	await fade_to_black()
	await fade_to_default()
