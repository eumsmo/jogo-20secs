extends Node

@export var marker_scene: PackedScene
@export var marker_material: ShaderMaterial
@export var duration_time: float = 1.0
var interactables: Array[Interactable]
var tween: Tween

func _ready() -> void:
	Game.instance.on_game_started.connect(get_interactables)

func get_interactables():
	if not Game.instance.current_level.has_interactable_marker:
		return
	
	var scene = Game.instance.current_level_scene
	var objs = scene.find_children("", "Interactable")
	interactables.assign(objs)

func spawn_markers():
	if tween != null:
		tween.stop()
	
	for child in get_children():
		child.queue_free()
	
	for interactable in interactables:
		if interactable != null and interactable.is_enabled() and interactable.can_interact():
			spawn_marker_for_interactable(interactable)
	
	tween = create_tween()
	tween.tween_method(func(ratio): marker_material.set_shader_parameter("radius", ratio), 0.0, 1.0, 1.0)
	tween.play()

func spawn_marker_for_interactable(interactable: Interactable):
	var owner: Node3D = interactable.shape_owner_get_owner(0)
	if owner == null:
		return
	
	var pos = owner.global_position
	
	var marker: Node3D = marker_scene.instantiate()
	add_child(marker)
	
	marker.duration_time = duration_time
	marker.global_position = pos
	
	var cam := get_viewport().get_camera_3d()
	marker.look_at(cam.global_position, Vector3.UP)
	
