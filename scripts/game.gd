class_name Game
extends Node3D

static var instance: Game

static var previous_level: LevelInfo
static var current_level: LevelInfo

@export var first_level: LevelInfo
@export var level_scene_relation: Dictionary[LevelInfo, Scene]

@export_group("Controllers")
@export var scenes: ScenesController
@export var pattern: InGamePatternListener
@export var inventory: Inventory

enum Direction { UP, LEFT, DOWN, RIGHT }

func _init() -> void:
	instance = self

func _ready() -> void:
	await get_tree().physics_frame
	GrandTimer.instance.start_timer()

func change_chapter(level: LevelInfo):
	previous_level = current_level
	current_level = level
	
	UIManager.instance.intro.bring_back_intro()
