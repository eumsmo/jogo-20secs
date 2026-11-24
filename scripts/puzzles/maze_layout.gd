class_name MazeLayout
extends Resource

@export var maze: Array[Array]


func get_random_available_pos_in_column(i: int) -> int:
	var available_count = 0
	for j in range(0, maze[i].size()):
		if not maze[i][j]:
			available_count += 1
	
	var pos = randi_range(0, available_count-1)
	var a = 0
	for j in range(0, maze[i].size()):
		if maze[i][j]:
			continue
		if a == pos:
			return j
		a += 1
	return -1
