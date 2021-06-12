extends State

var max_health : int = 1000
var current_health : int = max_health

var current_damage_per_frame = 0

var closest_zombie
var run_speed = 500
var move_vector = get_wander_vector()

signal change_state

func enter():
	pass
	
func exit():
	pass

func _process(delta):
	current_health -= current_damage_per_frame
	if current_health <= 0:
		emit_signal("change_state", "Zombie")
	
	run_from_zombies()
	
	host.add_force(move_vector * delta, tumble_vector)
	
	
func set_is_taking_damage(is_taking_damage):
	self.is_taking_damage = is_taking_damage

func get_damage_if_zombie(area):
	var zombie_state = get_zombie_state(area)
	if zombie_state:
		return zombie_state.get_infection_damage()
	return 0
	
func run_from_zombies():
	if closest_zombie:
		move_vector = -(closest_zombie.translation - host.translation).normalized() * run_speed

func _on_InfectionRadius_area_entered(area):
	current_damage_per_frame += get_damage_if_zombie(area)

func _on_InfectionRadius_area_exited(area):
	current_damage_per_frame -= get_damage_if_zombie(area)
		
func _on_RunRadius_area_entered(area):
	var zombie_state = get_zombie_state(area)
	if zombie_state:
		closest_zombie = area.get_parent()

func _on_RunRadius_area_exited(area):
	move_vector = get_wander_vector()
	closest_zombie = null
	
func get_zombie_state(area):
	if area.get_parent().has_method("get_state"):
		var entity = area.get_parent()
		if entity.get_state().get_name() == "Zombie":
			return entity.get_state()
	return null
	
func get_wander_vector():
	return Vector3.BACK * run_speed
