extends Spatial


var zombies = []

func _ready():
	get_zombies()

func get_zombies():
	for child in get_children():
		if child.has_method("get_state") and child.get_state().get_name() == "Zombie":
			zombies.insert[child]
