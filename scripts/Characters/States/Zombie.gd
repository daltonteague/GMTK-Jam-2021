extends State

export var skin : Material

var move_speed = 700
var slowdown_speed = 2000
var death_pop_force = 500

var damage_per_frame = 24

signal zombie_dead

func enter():
	print("entering zombo")
	change_skin_color()
	host.get_node("SightRadius").queue_free()
	pass

func _physics_process(delta):
	var input = apply_player_input(delta)
	apply_slowdown_force(delta)

func apply_slowdown_force(delta):
	if Input.is_action_just_released("move_backward") or Input.is_action_just_released("move_forward"):
		var inv_z = -Vector3(0, 0, host.linear_velocity.z) * slowdown_speed * delta
		host.add_force(inv_z, Vector3.ZERO)
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		var inv_x = -Vector3(host.linear_velocity.x, 0, 0) * slowdown_speed * delta
		host.add_force(inv_x, Vector3.ZERO)
	
	change_skin(skin)

func apply_player_input(delta):
	var input = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0, 
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized() * move_speed * delta
	
	host.add_force(input, tumble_vector)
	
	return input

func change_skin_color():
	var mat = host.get_node("Skin").get_mesh().surface_get_material(0)
	mat.albedo_color = Color(.2, 1, .2, 1)
	host.get_node("Skin").get_mesh().surface_set_material(0, mat)
	
func change_skin(material):
	host.get_node("Skin").get_mesh().surface_set_material(0, material)

func get_infection_damage():
	return damage_per_frame
	
func take_damage(damage):
	if current_health <= 0:
		return
	current_health -= damage
	
	if current_health <= 0:
		host.add_central_force(Vector3.UP * death_pop_force)
		emit_signal("zombie_dead")
		emit_signal("change_state", "Dead")
