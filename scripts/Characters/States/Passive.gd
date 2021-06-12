extends State

var max_health : int = 1000
var current_health : int = max_health

var current_damage_per_frame = 0

signal change_state

func enter():
	pass
	
func exit():
	pass

func _process(delta):
	current_health -= current_damage_per_frame
	if current_health <= 0:
		emit_signal("change_state", "Zombie")

func set_is_taking_damage(is_taking_damage):
	self.is_taking_damage = is_taking_damage

func get_damage_if_zombie(area):
	if area.get_parent().has_method("get_state"):
		var entity = area.get_parent()
		if entity.get_state().get_name() == "Zombie":
			return entity.get_state().get_infection_damage()
	return 0

func _on_InfectionRadius_area_entered(area):
	current_damage_per_frame += get_damage_if_zombie(area)

func _on_InfectionRadius_area_exited(area):
	current_damage_per_frame -= get_damage_if_zombie(area)
		
