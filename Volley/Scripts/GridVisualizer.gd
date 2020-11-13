extends Node2D

onready var grid = get_parent()
onready var half_tile_offset = grid.cell_size/2
func cartesian_to_isometric(cartesian):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y)/2)
func _ready():
	#modulate = Color(1, 1, 0, 1)
	pass
func _draw():
	
	#draw grid
	var LINE_COLOR = Color(255, 255, 255)
	var LINE_WIDTH = 1
	var window_size = OS.get_window_size()
	for x in range(grid.grid_size.x+1):
		var col_pos = (x * grid.cell_size.x/2) 
		var limit = (grid.grid_size.y * grid.cell_size.y)  
		var iso_col_pos = cartesian_to_isometric(Vector2(col_pos, 0 ))
		var iso_col_lim = cartesian_to_isometric(Vector2(col_pos, limit))
		draw_line(iso_col_pos, iso_col_lim, LINE_COLOR, LINE_WIDTH)
	for y in range((grid.grid_size.y+1)):
		var row_pos = (y* grid.cell_size.y) 
		var limit = (grid.grid_size.x * grid.cell_size.x/2) 
		var iso_row_pos = cartesian_to_isometric(Vector2(0  , row_pos))
		var iso_row_lim = cartesian_to_isometric(Vector2(limit, row_pos ))
		draw_line(iso_row_pos, iso_row_lim, LINE_COLOR, LINE_WIDTH)
	draw_line(grid.map_to_world(Vector2(4,15)), grid.map_to_world(Vector2(14,15)), "black")
	draw_line(grid.map_to_world(Vector2(4,12)), grid.map_to_world(Vector2(14,12)), "041894")
	draw_line(grid.map_to_world(Vector2(4,18)), grid.map_to_world(Vector2(14,18)), "041894")
#	for x in range(grid.grid_size.x+1):
#		if x == 0:
#			pass
#		else:
#			var col_pos = (x * grid.cell_size.x/2) + (grid.cell_size.x)
#			var limit = (grid.grid_size.y * grid.cell_size.y)  + grid.cell_size.x
#			var iso_col_pos = cartesian_to_isometric(Vector2(col_pos, 0 + 1.5*grid.cell_size.x))
#			var iso_col_lim = cartesian_to_isometric(Vector2(col_pos, limit))
#			draw_line(iso_col_pos, iso_col_lim, LINE_COLOR, LINE_WIDTH)
#	for y in range((grid.grid_size.y+2)):
#		if y == 0:
#			pass
#		else:
#			var row_pos = (y* grid.cell_size.y) + (grid.cell_size.y)
#			var limit = (grid.grid_size.x * grid.cell_size.x/2) + grid.cell_size.x
#			var iso_row_pos = cartesian_to_isometric(Vector2(0 + 1.5*grid.cell_size.x , row_pos))
#			var iso_row_lim = cartesian_to_isometric(Vector2(limit, row_pos ))
#			draw_line(iso_row_pos, iso_row_lim, LINE_COLOR, LINE_WIDTH)

	
