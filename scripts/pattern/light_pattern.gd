extends Node

@export var mat: BaseMaterial3D
@export var lights: Array[OmniLight3D]
@export var on_color: Color
@export var off_color: Color

@export var on_light_attenuation: float
@export var off_light_attenuation: float


@export_category("Configs")
@export var pattern: Array[Game.Direction]
@export var pattern_blinks: Dictionary[Game.Direction, int]

@export var start_on := true
@export var off_when_stopped := false
@export var on_time: float = 0.3
@export var off_time: float = 0.1
@export var between_time: float = 0.3


var current_tween : Tween

func _ready() -> void:
	if start_on:
		start_pattern()

func start_pattern():
	if current_tween != null:
		return
	
	current_tween = create_tween()
	
	for i in range(0, len(pattern)):
		var current_pattern = pattern[i]
		var blink_count = pattern_blinks[current_pattern]
		
		for j in range(0, blink_count):
			current_tween.tween_callback(set_on).set_delay(off_time)
			current_tween.tween_callback(set_off).set_delay(on_time)
		current_tween.tween_interval(between_time)
	
	current_tween.set_loops()
	current_tween.play()

func stop_pattern():
	if current_tween != null:
		current_tween.kill()
		current_tween = null
	
	if off_when_stopped:
		set_off()
	else:
		set_on()

func set_on():
	mat.albedo_color = on_color
	
	for light in lights:
		light.omni_attenuation = on_light_attenuation


func set_off():
	mat.albedo_color = off_color
	
	for light in lights:
		light.omni_attenuation = off_light_attenuation
