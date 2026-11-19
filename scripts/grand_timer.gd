class_name GrandTimer
extends Node

static var instance: GrandTimer
@export var timer: Timer

signal on_progress(progress: float)
signal on_ended

func _init() -> void:
	instance = self

func _ready() -> void:
	timer.timeout.connect(on_timer_ended)

func start_timer():
	timer.start()

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		return
	
	on_progress.emit(timer.time_left / timer.wait_time)

func on_timer_ended():
	on_progress.emit(0.0)
	on_ended.emit()
