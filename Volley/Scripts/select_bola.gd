extends Sprite


var direction_ball = Vector2()

const MAX_SPEED = 200
onready var grid = get_parent().get_parent()
onready var sorter = grid.get_child(2)
onready var polygon_drawer = get_parent()
var speed = 0
var motion = Vector2()
var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false
func cartesian_to_isometric(vector):
	return Vector2(vector.x - vector.y, (vector.x + vector.y) / 2)
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if polygon_drawer.select_on == true:
		var direction_ball = Vector2()
		if Input.is_action_pressed("up"):
			direction_ball.y = -1
		elif Input.is_action_pressed("down"):
			direction_ball.y = 1
		if Input.is_action_pressed("left"):
			direction_ball.x = -1
		elif Input.is_action_pressed("right"):
			direction_ball.x = 1
		if grid.is_cell_vacant_mov(get_position(), direction_ball):
			var target_direction = direction_ball.normalized()
			var speed = 200
			var motion = speed * target_direction * delta
			motion = cartesian_to_isometric(motion)
			translate(motion)
	else:
		pass
