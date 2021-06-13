extends State
class_name BaseNPC

onready var sight_radius = host.get_node("SightRadius")
onready var infection_radius = host.get_node("InfectionRadius")

export var start_skin : Material
export var zombie_skin : Material

var current_damage_per_frame = 0

var closest_zombie
var run_speed = 500

var wander_timer = Timer.new()
var wander_directions = [
	Vector3.FORWARD, Vector3.BACK, Vector3.LEFT, Vector3.RIGHT] 

var move_vector = get_wander_vector()

func enter():
	change_skin(start_skin)
	wander_timer.connect("timeout", self, "get_wander_vector")
	wander_timer.set_wait_time(5)
	wander_timer.start()
	
func _ready():
	host.get_node("SightRadius").connect("area_entered", self, "_on_SightRadius_area_entered")
	host.get_node("SightRadius").connect("area_exited", self, "_on_SightRadius_area_exited")

func _process(delta):
	current_health -= current_damage_per_frame
	if current_health <= 0:
		anim_player.play("Bounce")
		emit_signal("infected", blood_splash, host.global_transform)
		emit_signal("change_state", "Zombie")
	
	if !closest_zombie:
		host.add_force(move_vector * delta, tumble_vector)
	
	check_areas()
	interpolate_skin_color()

func check_areas():
	if sight_radius.get_overlapping_areas().size() > 0 and !closest_zombie:
		_on_SightRadius_area_entered(sight_radius.get_overlapping_areas()[0])
#	if infection_radius.get_overlapping_areas().size() > 0 and current_damage_per_frame <= 0:
#		for area in infection_radius.get_overlapping_areas():
#			if get_zombie_state(area):
#				_on_InfectionRadius_area_entered(infection_radius.get_overlapping_areas()[0])
#				return
	
func interpolate_skin_color():
	var current_skin = host.get_node("Skin").get_mesh().surface_get_material(0).duplicate()
	var percent_health = float(current_health) / max_health
	
	var new_color = lerp(zombie_skin.albedo_color, start_skin.albedo_color, percent_health)

	current_skin.albedo_color = new_color
	host.get_node("Skin").get_mesh().surface_set_material(0, current_skin)

func set_is_taking_damage(is_taking_damage):
	self.is_taking_damage = is_taking_damage

func get_damage_if_zombie(area):
	var zombie_state = get_zombie_state(area)
	if zombie_state:
		return zombie_state.get_infection_damage()
	return 0
	

func change_skin(material):
	host.get_node("Skin").get_mesh().surface_set_material(0, material)

func _on_InfectionRadius_area_entered(area):
	current_damage_per_frame += get_damage_if_zombie(area)

func _on_InfectionRadius_area_exited(area):
	current_damage_per_frame -= get_damage_if_zombie(area)
	if current_damage_per_frame < 0:
		current_damage_per_frame = 0
		
func _on_SightRadius_area_entered(area):
	var zombie_state = get_zombie_state(area)
	if zombie_state:
		closest_zombie = area.get_parent()

func _on_SightRadius_area_exited(area):
	var zombie_state = get_zombie_state(area)
	if zombie_state:
		move_vector = get_wander_vector()
		closest_zombie = null
	
func get_zombie_state(area):
	if area.get_parent().has_method("get_state"):
		var entity = area.get_parent()
		if entity.get_state().get_name() == "Zombie":
			return entity.get_state()
	return null
	
func get_wander_vector():
	randomize()
	var direction = wander_directions[randi() % wander_directions.size()]
	return direction * run_speed * .8
