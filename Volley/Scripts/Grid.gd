extends TileMap

enum TIPOS{EMPTY, PLAYER, MOV_AVAILABLE, COLLECTIBLE, PLAYER2}

var grid = []
var grid_mov_available = []
var grid_size = Vector2(18,30)
var tile_size = cell_size
var player_startpos = Vector2(8,8)
var player_startpos2 = Vector2(9,18)
var player_startpos3 = Vector2(6,20)
var player_startpos4 = Vector2(12,20)
var player_startpos5 = Vector2(9,23)
var ball_pos = Vector2()


onready var Player2 = preload("res://Player2.tscn")
onready var Ball = preload("res://Bola.tscn")
onready var Sorter = get_child(2)

func _ready():
	#grid
	for i in range(grid_size.x):
		grid.append([])
		grid_mov_available.append([])
		for j in range(grid_size.y):
			grid[i].append(TIPOS.EMPTY)
			grid_mov_available[i].append(TIPOS.EMPTY)
	#player
#	var new_player = Player.instance()
#	new_player.position = map_to_world(player_startpos)
#	grid[player_startpos.x][player_startpos.y] = TIPOS.PLAYER
#	Sorter.add_child(new_player)
	
	#var ball_on = Ball.instance()
	
	
	var player_2 = Player2.instance()
	player_2.position = map_to_world(player_startpos2)
	grid[player_startpos2.x][player_startpos2.y] = TIPOS.PLAYER
	Sorter.add_child(player_2)
	
	var player_3 = Player2.instance()
	player_3.position = map_to_world(player_startpos3)
	grid[player_startpos3.x][player_startpos3.y] = TIPOS.PLAYER
	Sorter.add_child(player_3)
	
	var player_4 = Player2.instance()
	player_4.position = map_to_world(player_startpos4)
	grid[player_startpos4.x][player_startpos4.y] = TIPOS.PLAYER
	Sorter.add_child(player_4)
	
	var player_5 = Player2.instance()
	player_5.position = map_to_world(player_startpos5)
	grid[player_startpos5.x][player_startpos5.y] = TIPOS.PLAYER
	Sorter.add_child(player_5)
	#obstacles
	



func is_cell_vacant(pos, direction):
	var grid_pos =  world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0 :
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y]  == TIPOS.EMPTY else  false
	return false

func is_cell_vacant_mov(pos, direction):
	var grid_pos =  world_to_map(pos) + direction
	return true if grid_mov_available[grid_pos.x][grid_pos.y]  == TIPOS.MOV_AVAILABLE else  false
func update_child(pos, direction, type):
	var grid_pos = world_to_map(pos)
	grid[grid_pos.x][grid_pos.y] = TIPOS.EMPTY
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = type
	var target_pos = map_to_world(new_grid_pos)
	return target_pos

func update_child_click(position, target_position, type):
	var grid_pos = world_to_map(position)
	grid[grid_pos.x][grid_pos.y] = TIPOS.EMPTY
	var new_grid_pos = world_to_map(target_position)
	grid[new_grid_pos.x][new_grid_pos.y] = type
	return target_position

func state_grid(pos):
	var grid_pos = world_to_map(pos)
	var old_grid_pos = world_to_map(player_startpos)
	#print(old_grid_pos)
	##print(player_startpos)
	##print(grid[old_grid_pos.x][old_grid_pos.y])






