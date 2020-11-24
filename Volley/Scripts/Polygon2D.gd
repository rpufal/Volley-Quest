extends Polygon2D
var outside_court
var outside_colors
var vertices_poli
var court_colors 
var vertices_tile
var color_tile_selected
var selectable_tiles
var range_mean = Vector2()
var tile 
var mov_grid = []
onready var grid = get_parent()
onready var sorter = grid.get_child(2)
onready var Ball = preload("res://Bola.tscn")
onready var select_on = false
var ball_selection
var current_pos
var player
var draw_p = {"0": false, "1": false , "2": false, "3": false}

func _ready():
	
	
	
	# coordenadas p mapa todo
	var o1 = grid.map_to_world(Vector2(0,0))
	var o2 = grid.map_to_world(Vector2(18,0))
	var o3 = grid.map_to_world(Vector2(18,30))
	var o4 = grid.map_to_world(Vector2(0,30))
	# coordenadas p quadra
	var p1 = grid.map_to_world(Vector2(4,6))
	var p2 = grid.map_to_world(Vector2(14,6))
	var p3 = grid.map_to_world(Vector2(14,24))
	var p4 = grid.map_to_world(Vector2(4,24))
	vertices_poli = PoolVector2Array([p1,p2,p3,p4])
	outside_court = PoolVector2Array([o1,o2,o3,o4])
	outside_colors = PoolColorArray([Color(0, 199, 235,255)])
	court_colors = PoolColorArray([Color("fa8405")])
	selectable_tiles = PoolColorArray([Color("31f566")])
	#prepare array of coordinates to draw things
	var area = grid.grid_size
	var m1 = Vector2()
	var m2 = Vector2()
	var m3 = Vector2()
	var m4 = Vector2()
	vertices_tile = PoolVector2Array([m1,m2,m3,m4])
	for i in range(area.x):
		mov_grid.append([])
		for j in range(area.y):
			if i < j:
				m1.x = (32*i) - (32*j) 
				m2.x = m1.x+32
				m3.x = m1.x
				m4.x = m2.x -64
				m1.y = (16*j) + (16*i)
				m2.y = m1.y + 16
				m3.y = m1.y + 32
				m4.y = m1.y + 16
			else:
				m1.x = (32*i) - (32*j) 
				m2.x = m1.x+32
				m3.x = m1.x
				m4.x = m2.x -64 
				m1.y = (16*j) + (16*i)
				m2.y = m1.y + 16
				m3.y = m1.y + 32
				m4.y = m1.y + 16
			vertices_tile = PoolVector2Array([m1,m2,m3,m4])
			mov_grid[i].append(vertices_tile)
	color_tile_selected = PoolColorArray([Color("16cc47")])
func _draw():
	#draw outside court
	draw_polygon(outside_court, outside_colors)
	#draw inside court
	draw_polygon(vertices_poli, court_colors)
	#draw square under selected player
	if true in draw_p.values():
		for i in range(sorter.n_children):
			if draw_p[str(i)] == true:
				var p_sel = sorter.get_child(i).current_pos
				draw_polygon(mov_grid[p_sel.x][p_sel.y], color_tile_selected)


	# prepare selectable ranges and selected tile
	for i in range(4):
		if sorter.get_child(i).prepare_serve == true:
			var grid_t1 = Vector2(6,7)
			var grid_t2 = Vector2(9,7)
			var grid_t3 = Vector2(9,10)
			var grid_t4 = Vector2(6,10)
			var world_t1 = grid.map_to_world(grid_t1)
			var world_t2 = grid.map_to_world(grid_t2)
			var world_t3 = grid.map_to_world(grid_t3)
			var world_t4 = grid.map_to_world(grid_t4)
			for j in range(3):
				grid.grid_mov_available[5+j][6+j] = grid.TIPOS.MOV_AVAILABLE
			var action_range = PoolVector2Array([world_t1,world_t2,world_t3,world_t4])
			range_mean.x = (grid_t1.x + grid_t2.x + grid_t3.x + grid_t4.x - 2)/4
			range_mean.y = (grid_t1.y + grid_t2.y + grid_t3.y + grid_t4.y - 2)/4
			#create ball used to select tiles
			draw_polygon(action_range, selectable_tiles)
			draw_polygon(mov_grid[range_mean.x][range_mean.y], color_tile_selected)
			ball_selection.position = grid.map_to_world(range_mean)
			sorter.get_child(i).prepare_serve = false
			sorter.get_child(i).prepare_action = false

func _physics_process(delta):
	if sorter.can_draw == true:
		for i in range(sorter.n_children):
			# verify which player is selected
			if sorter.get_child(i).character_select == true:
				var p_index = str(i)
				draw_p[p_index] = true
				for j in range(sorter.n_children):
					if j != i :
						p_index = str(j)
						draw_p[p_index] = false
			# update _draw() for square under selected player
			if sorter.get_child(i).character_draw == true:
#				var player_selected = sorter.get_child(i)
				update()
				sorter.get_child(i).character_draw = false
			
			# draw range of selection for serving 
			if sorter.get_child(i).prepare_serve == true:
				update()
				if get_child_count() == 0:
					ball_selection = Ball.instance()
					ball_selection.position = grid.map_to_world(range_mean)
					add_child(ball_selection)
					print(get_child_count())
				elif get_child_count() ==  1:
					print(get_child_count())
					#move selectable square
					select_on = true
