extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 200


var speed = 0
var motion = Vector2()
var character_select = false
var character_draw = false
var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false
var teste_click = false
onready var grid = get_parent().get_parent()
onready var type = grid.TIPOS.PLAYER
var current_pos 
func cartesian_to_isometric(vector):
	return Vector2(vector.x - vector.y, (vector.x + vector.y) / 2)

func _ready():
	# The Player is now a child of the YSort node, so we have to go 1 more step up the node tree
	$Sprite.play("idle_n")


	
func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = grid.world_to_map(get_global_mouse_position())
		if mouse_pos == grid.world_to_map(get_position()):
			character_select = true
			character_draw = true
		else:
			character_select = false
			character_draw = false

func _physics_process(delta):
	direction = Vector2()
	speed = 0
	current_pos = grid.world_to_map(get_position())
	if character_select == true:
		
		##Movimentacao por mouse
		if teste_click == true:
			motion = position.direction_to(target_pos) * MAX_SPEED
			if position.distance_to(target_pos) > 5:
				motion = move_and_slide(motion)
			elif position == target_pos:
				teste_click == false
		
		#normal movements
		if Input.is_action_pressed("up"):
			direction.y = -1
			$Sprite.play("walk_n")
		elif Input.is_action_pressed("down"):
			direction.y = 1
			$Sprite.play("walk_s")

		if Input.is_action_pressed("left"):
			direction.x = -1
			$Sprite.play("walk_w")
		elif Input.is_action_pressed("right"):
			direction.x = 1
			$Sprite.play("walk_e")
		
		#diagonal
		if Input.is_action_pressed("right") and Input.is_action_pressed("up"):
			$Sprite.play("walk_ne")
		elif Input.is_action_pressed("right") and Input.is_action_pressed("down"):
			$Sprite.play("walk_se")
		if Input.is_action_pressed("left") and Input.is_action_pressed("down"):
			$Sprite.play("walk_sw")
		elif Input.is_action_pressed("up") and Input.is_action_pressed("left"):
			$Sprite.play("walk_nw")
		
		
		#not moving animation
		if $Sprite.animation == "walk_n" and direction == Vector2():
			$Sprite.play("idle_n")
		elif $Sprite.animation == "walk_s" and direction == Vector2():
			$Sprite.play("idle_s")
		elif $Sprite.animation == "walk_w" and direction == Vector2():
			$Sprite.play("idle_w")
		elif $Sprite.animation == "walk_e" and direction == Vector2():
			$Sprite.play("idle_e")
		elif $Sprite.animation == "walk_nw" and direction == Vector2():
			$Sprite.play("idle_nw")
		elif $Sprite.animation == "walk_sw" and direction == Vector2():
			$Sprite.play("idle_sw")
		elif $Sprite.animation == "walk_ne" and direction == Vector2():
			$Sprite.play("idle_ne")
		elif $Sprite.animation == "walk_se" and direction == Vector2():
			$Sprite.play("idle_se")
		
		if Input.is_action_pressed("ui_accept"):
			print(current_pos)
			#print(grid.map_to_world(current_pos))
		if not is_moving and direction != Vector2():
			target_direction = direction.normalized()
			
			if grid.is_cell_vacant(get_position(), direction):
				target_pos = grid.update_child(get_position(), direction, type)
				is_moving = true
		elif is_moving:
			speed = MAX_SPEED
			motion = cartesian_to_isometric(speed * target_direction * delta)
			var pos = get_position()
			var distance_to_target = pos.distance_to(target_pos)
			var move_distance = motion.length()
			if move_distance > distance_to_target: # se a intensidade do vetor de movimentação for maior que a distancia , set_pos automaticamente (ultima parte do movimento)
				set_position(target_pos)
				is_moving = false
			else:
				translate(motion)
	else:
		pass
#func _draw():
#	var mcurrent_pos = grid.map_to_world(current_pos)
#	var quad_pos = PoolVector2Array([Vector2(mcurrent_pos.x + 16, mcurrent_pos.y - 8), Vector2(mcurrent_pos.x + 48, mcurrent_pos.y - 8), Vector2(mcurrent_pos.x + 48, mcurrent_pos.y + 8), Vector2(mcurrent_pos.x + 16, mcurrent_pos.y + 8)])
#	#var under_color = Color(grid.get_child(0).court_colors)
#	#print(under_color)
#	var quad_color = PoolColorArray(["b55f02"])
#	draw_polygon(quad_pos, quad_color)
#func move_square():
#	pass
