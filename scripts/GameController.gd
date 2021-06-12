extends Spatial


var zombies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	get_zombies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_zombies():
	for child in get_children():
		if child.has_method("get_state") and child.get_state().get_name() == "Zombie":
			zombies.insert[child]
