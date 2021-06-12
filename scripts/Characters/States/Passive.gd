extends State

onready var host = get_parent().get_parent()

export var start_skin : Material
export var zombie_skin : Material

var max_health : int = 1000
var current_health : int = max_health

var current_damage_per_frame = 0

signal change_state

func enter():
	change_skin(start_skin)

func exit():
	pass

func _ready():
	print([start_skin.albedo_color.r, start_skin.albedo_color.g, start_skin.albedo_color.b])
	print([zombie_skin.albedo_color.r, zombie_skin.albedo_color.g, zombie_skin.albedo_color.b])
	print(host.get_node("Skin").get_mesh().surface_get_material(0))
	

func _process(delta):
	current_health -= current_damage_per_frame
	if current_health <= 0:
		emit_signal("change_state", "Zombie")

	interpolate_skin_color()

func interpolate_skin_color():
	var current_skin = host.get_node("Skin").get_mesh().surface_get_material(0).duplicate()
	var percent_health = float(current_health) / max_health
	
	print([zombie_skin.albedo_color.r, current_skin.albedo_color.r, percent_health])
	
	var new_color = lerp(zombie_skin.albedo_color, start_skin.albedo_color, percent_health)

	current_skin.albedo_color = new_color
	host.get_node("Skin").get_mesh().surface_set_material(0, current_skin)


func set_is_taking_damage(is_taking_damage):
	self.is_taking_damage = is_taking_damage

func get_damage_if_zombie(area):
	if area.get_parent().has_method("get_state"):
		var entity = area.get_parent()
		if entity.get_state().get_name() == "Zombie":
			return entity.get_state().get_infection_damage()
	return 0

func change_skin(material):
	host.get_node("Skin").get_mesh().surface_set_material(0, material)

func _on_InfectionRadius_area_entered(area):
	current_damage_per_frame += get_damage_if_zombie(area)

func _on_InfectionRadius_area_exited(area):
	current_damage_per_frame -= get_damage_if_zombie(area)
