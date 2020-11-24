extends YSort

var characters = []
onready var n_children = 4
var can_draw


func _physics_process(delta):
	for i in range(n_children):
		if get_child(i).character_draw == true:
			can_draw = true
