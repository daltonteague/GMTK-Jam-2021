extends State

onready var host = get_parent().get_parent()

export var skin : Material

var move_speed = 700
var max_speed = 12000

var damage_per_frame = 10

var tumble_magnitude = 2

func enter():
	print("entering zombo")
	change_skin(skin)

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
		
func change_skin(material):
	host.get_node("Skin").get_mesh().surface_set_material(0, material)

func get_infection_damage():
	return damage_per_frame
