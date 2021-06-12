extends State

onready var host = get_parent().get_parent()

var move_speed = 700
var max_speed = 12000

var tumble_magnitude = 1

func enter():
	print("entering zombo")
	change_skin_color()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_player_input(delta)


func apply_player_input(delta):
	var input = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0, 
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized() * move_speed * delta
	
	host.add_force(input, Vector3(0, tumble_magnitude, 0))

func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity=state.linear_velocity.normalized() * max_speed
		
func change_skin_color():
	var mat = host.get_node("Skin").get_mesh().surface_get_material(0)
	mat.albedo_color = Color(.2, 1, .2, 1)
	host.get_node("Skin").get_mesh().surface_set_material(0, mat)
