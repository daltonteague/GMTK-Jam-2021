extends State

onready var zomb_blood_splash = preload("res://scenes/GreenBloodSplash.tscn")

export var skin : Material

var move_speed = 1200
var boost_magnitude = 1200
var death_pop_force = 500

var damage_per_frame = 24

signal zombie_dead

func enter():
	print("entering zombo")
	change_skin(skin)
	host.get_node("SightRadius").queue_free()

func _physics_process(delta):
	apply_player_input(delta)

func apply_player_input(delta):
	var current_move_speed = move_speed
	var input = get_player_movement_vector() 
	
	if input.dot(host.linear_velocity) < 0:
		current_move_speed += move_speed + boost_magnitude
	
	input *= current_move_speed * delta 
	
	host.add_force(input, tumble_vector)
	return input
	
func get_player_movement_vector():
	return Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0, 
		Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	).normalized() 
	
func change_skin(material):
	host.get_node("Skin").get_mesh().surface_set_material(0, material)

func get_infection_damage():
	return damage_per_frame
	
func take_damage(damage):
	print("ow " + str(current_health))
	emit_signal("infected", zomb_blood_splash, host.global_transform)
	if current_health <= 0:
		return
	current_health -= damage
	
	if current_health <= 0:
		host.add_central_force(Vector3.UP * death_pop_force)
		emit_signal("zombie_dead")
		emit_signal("change_state", "Dead")
