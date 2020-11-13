extends Polygon2D
var outside_court
var outside_colors
var vertices_poli
var court_colors 
var vertices_tile
var color_tile
var tile 
var mov_grid = []
onready var grid = get_parent()
onready var sorter = grid.get_child(2)
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
	color_tile = PoolColorArray([Color("2cf562")])
func _draw():
	draw_polygon(outside_court, outside_colors)
	draw_polygon(vertices_poli, court_colors)
	if true in draw_p.values():
		for i in range(sorter.n_children):
			if draw_p[str(i)] == true:
				var p_sel = sorter.get_child(i).current_pos
				draw_polygon(mov_grid[p_sel.x][p_sel.y], color_tile)
#		draw_polygon(mov_grid[9][18], color_tile)
	

#duvida de codigo confuso
func _physics_process(delta):
	if sorter.can_draw == true:
		for i in range(sorter.n_children):
			if sorter.get_child(i).character_select == true:
				var p_index = str(i)
				draw_p[p_index] = true
				for j in range(sorter.n_children):
					if j != i :
						p_index = str(j)
						draw_p[p_index] = false
			if sorter.get_child(i).character_draw == true:
				var player_selected = sorter.get_child(i)
				update()
#				print(draw_p)
#				print(mov_grid[player_selected.current_pos.x][player_selected.current_pos.y])
				sorter.get_child(i).character_draw = false
				#draw_polygon( mov_grid[player_selected.], color_tile)
#				sorter.get_child(i).character_select = false
			
