extends YSort

var characters = []
var n_children
var can_draw
func _ready():
#	n_children = get_child_count()
	n_children = 4
	for i in range(n_children):
		characters.append(i)
	pass # Replace with function body.
func _physics_process(delta):
	for i in range(n_children):
		if get_child(i).character_draw == true:
			can_draw = true
