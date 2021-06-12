extends RigidBody


# Declare member variables here. Examples:
var move_speed = 700
var max_speed = 12000

var tumble_magnitude = 1

# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	add_force(input, Vector3(0, tumble_magnitude, 0))

func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity=state.linear_velocity.normalized() * max_speed
