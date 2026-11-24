class_name IntroManager
extends Control

@export_group("Control Refs")
@export var label: Label
@export var chapter_label: Label
@export var arrows_holder: Control
@export var intro_blocker: ColorRect
@export var intro_fade: ColorRect
@export var click_show: Control

@export_group("Other Refs")
@export var game: Game
@export var timer: GrandTimer
@export var pattern_listener: SimplePatternListener
var arrow_idx: int = 0

@export var arrows_prefabs: Dictionary[Game.Direction, PackedScene]

@export_category("Configs")
@export var normal_color: Color
@export var active_color: Color

func _ready() -> void:
	pattern_listener.pattern_added.connect(on_new_direction)
	pattern_listener.pattern_cleared.connect(on_clear_direction)
	pattern_listener.on_correct.connect(on_pattern_right)
	intro_fade.material = intro_fade.material.duplicate()
	intro_blocker.material = intro_blocker.material.duplicate()
	
	game.process_mode = Node.PROCESS_MODE_DISABLED
	timer.process_mode = Node.PROCESS_MODE_DISABLED
	pattern_listener.process_mode = Node.PROCESS_MODE_DISABLED
	
	if Game.current_level == null:
		Game.current_level = game.first_level

	set_info(Game.current_level)
	

func set_info(level_info: LevelInfo):
	label.text = level_info.name
	chapter_label.text = "~ Chapter {0} ~".format([level_info.chapter])
	pattern_listener.target_pattern = level_info.pattern
	
	for child in arrows_holder.get_children():
		child.queue_free()
	
	for dir in level_info.pattern:
		var instance: TextureRect = arrows_prefabs[dir].instantiate()
		instance.material = null
		instance.modulate = normal_color
		arrows_holder.add_child(instance)
	
	if level_info != Game.previous_level and Game.previous_level != null:
		UIManager.instance.shader.transition_palette(Game.previous_level.palette, level_info.palette)
	else:
		UIManager.instance.shader.set_palette(level_info.palette)
	
	Game.current_level = level_info
	ProgressManager.unlock_chapter(level_info)

func simple_timer(callback: Callable, inverted: bool = true):
	var time = 1.0
	var temp_timer = get_tree().create_timer(time)
	
	while temp_timer.time_left > 0.0:
		var progress = (temp_timer.time_left / time) if inverted else (1 - temp_timer.time_left / time)
		callback.call(progress)
		await get_tree().physics_frame
	
	callback.call(0.0 if inverted else 1.0)

func transition_circle(mat: ShaderMaterial, inverted: bool = true):
	await simple_timer(func(progress: float): mat.set_shader_parameter("dist_limit",progress), inverted)

func on_new_direction(dir: Game.Direction):
	var target_dir = pattern_listener.target_pattern[arrow_idx]
	
	if dir == target_dir:
		arrows_holder.get_child(arrow_idx).modulate = active_color
		arrow_idx += 1
	else:
		pattern_listener.reset_pattern()

func on_clear_direction():
	arrow_idx = 0
	
	for arrow in arrows_holder.get_children():
		arrow.modulate = normal_color

func on_pattern_right():
	pattern_listener.process_mode = Node.PROCESS_MODE_DISABLED
	game.process_mode = Node.PROCESS_MODE_INHERIT
	
	game.scenes.change_scene(game.level_scene_relation[game.current_level].starting_scene)
	game.game_actually_started()
	
	simple_timer(func(progress): modulate.a = progress)
	await transition_circle(intro_fade.material)
	
	timer.process_mode = Node.PROCESS_MODE_INHERIT
	timer.start_timer()
	
	process_mode = Node.PROCESS_MODE_DISABLED


func _on_intro_block_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_pressed():
			transition_circle(intro_blocker.material, false)
			click_show.visible = false
			intro_blocker.mouse_filter = Control.MOUSE_FILTER_IGNORE
			pattern_listener.process_mode = Node.PROCESS_MODE_INHERIT


func timer_ended():
	Game.previous_level = Game.current_level
	bring_back_intro()

func bring_back_intro():
	process_mode = Node.PROCESS_MODE_INHERIT
	game.process_mode = Node.PROCESS_MODE_DISABLED
	timer.process_mode = Node.PROCESS_MODE_DISABLED
	pattern_listener.process_mode = Node.PROCESS_MODE_DISABLED
	intro_blocker.mouse_filter = Control.MOUSE_FILTER_STOP
	
	await transition_circle(intro_fade.material, false)
	intro_blocker.material.set_shader_parameter("dist_limit",0.0)
	modulate.a = 1.0
	
	get_tree().call_deferred("change_scene_to_file","res://scenes/game_holder.tscn")
