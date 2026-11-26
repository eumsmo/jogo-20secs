extends Node


@export var patterned: Patterned
@export var scene_pattern: ScenePattern

@export var maze: MazeLayout

@export var maze_nodes: Node3D

@export var starter_node: Node3D
@export var end_node: Node3D

var start: Vector2i
var end: Vector2i

func _ready() -> void:
	generate_pattern()

func generate_pattern():
	var path: PackedVector2Array = path_find()

	var pattern: Array[Game.Direction] = get_pattern_from_point_path(path)
	
	patterned.pattern = pattern
	scene_pattern.pattern = pattern
	#print("MAZE: ", pattern.map(func(x): return Game.Direction.find_key(x)))
	
	for collumn in maze_nodes.get_children():
		for row in collumn.get_children():
			row.visible = false
	
	for pos in path:
		var col = maze_nodes.get_child(pos.x)
		var row = col.get_child(pos.y)
		row.visible = true
	
	var start_pos = path[0]
	var ending_pos = path[-1]
	
	var starting_node: Node3D = maze_nodes.get_child(start_pos.x).get_child(start_pos.y)
	starter_node.global_position = starting_node.global_position
	
	var ending_node: Node3D = maze_nodes.get_child(ending_pos.x).get_child(ending_pos.y)
	end_node.global_position = ending_node.global_position


func path_find() -> PackedVector2Array:
	var astar = AStarGrid2D.new()
	astar.region = Rect2i(0, 0, maze.maze.size(), maze.maze.size())
	astar.cell_size = Vector2.ONE
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	for i in range(astar.region.position.x, astar.region.end.x):
		for j in range(astar.region.position.y, astar.region.end.y):
			var pos = Vector2i(i, j)
			if maze.maze[i][j]:
				astar.set_point_solid(pos)
	
	var left_column_pos = 0 if randi_range(0,1) == 1 else 2
	var left_row_pos = maze.get_random_available_pos_in_column(left_column_pos)
	
	var right_column_pos = 4 if randi_range(0,1) == 1 else 6
	var right_row_pos = maze.get_random_available_pos_in_column(right_column_pos)

	if randi_range(0, 1) == 0:
		start = Vector2i(left_column_pos, left_row_pos)
		end = Vector2i(right_column_pos, right_row_pos)
	else:
		start = Vector2i(right_column_pos, right_row_pos)
		end = Vector2i(left_column_pos, left_row_pos)
	
	return astar.get_id_path(start, end)

func get_pattern_from_point_path(path: Array[Vector2]) -> Array[Game.Direction]:
	var directions: Array[Game.Direction]
	
	for i in range(0, len(path) - 1):
		var current = path[i]
		var next = path[i+1]
		directions.append(get_direction_between_points(current, next))
	
	if len(directions) < 2:
		return directions

	var pattern: Array[Game.Direction]
	pattern.append(directions[0])
	
	for i in range(1, len(directions)):
		var current = directions[i]
		var previous = directions[i-1]
		
		if current != previous:
			pattern.append(current)
	
	return pattern
	
func get_direction_between_points(from: Vector2, to: Vector2) -> Game.Direction:
	if from.x == to.x:
		return Game.Direction.UP if (from.y > to.y) else Game.Direction.DOWN
	return Game.Direction.LEFT if (from.x > to.x) else Game.Direction.RIGHT

#func filter_path(path: PackedVector2Array) -> Array[Vector2]:
