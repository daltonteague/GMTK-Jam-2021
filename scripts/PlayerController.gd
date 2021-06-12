extends RigidBody


# Declare member variables here. Examples:
var move_speed = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input = transform.basis.xform(Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	)).normalized() * move_speed * delta
	print(str(input))
	add_force(input, Vector3.UP)
