extends Spatial

#onready var remaining_humans_label = $RemainingText

var zombies = []
var humans = []
var zombie_count = 0
var human_count = 0

func _ready():
	get_humans()
	set_label_text()
	
func get_zombies():
	for child in get_children():
		if child.has_method("get_state") and child.get_state().get_name() == "Zombie":
			zombies.insert[child]
			zombie_count += 1
			
func get_humans():
	for child in get_children():
		if child.has_method("get_state") and (child.get_state().get_name() == "Passive" \
			or child.get_state().get_name() == "Aggressive"):
			humans.append(child)
			child.get_state().connect("change_state", self, "human_infected")
			human_count += 1

func human_infected(_state):
	print("got infected signal")
	human_count -= 1
	set_label_text()

func set_label_text():
	$RemainingText.text = "- Humans Left to Meet: " + str(human_count)
	
