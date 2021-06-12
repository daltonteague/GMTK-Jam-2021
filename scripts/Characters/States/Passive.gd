extends State

onready var host = get_parent().get_parent()
onready var blood_splash = preload("res://scenes/BloodSplash.tscn")

export var start_skin : Material
export var zombie_skin : Material

var max_health : int = 1000
var current_health : int = max_health

var current_damage_per_frame = 0

signal change_state
signal infected(blood_splash, transform)

func enter():
	change_skin(start_skin)

func exit():
	emit_signal("infected", blood_splash, host.global_transform)

func _ready():
	pass
	

func _process(delta):
	current_health -= current_damage_per_frame
	if current_health <= 0:
		emit_signal("change_state", "Zombie")

	interpolate_skin_color()

func interpolate_skin_color():
	var current_skin = host.get_node("Skin").get_mesh().surface_get_material(0).duplicate()
	var percent_health = float(current_health) / max_health
	
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
