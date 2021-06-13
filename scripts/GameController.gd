extends Spatial

var zombies = []
var humans = []
var zombie_count = 0
var human_count = 0

var timer = Timer.new()

signal level_complete

func _ready():
	count_zombies()
	count_humans()
	set_label_text()
	
	
func count_zombies():
	for child in get_children():
		if child.has_method("get_state") and child.get_state().get_name() == "Zombie":
			zombies.append(child)
			zombie_count += 1

func count_humans():
	for child in get_children():
		if child.has_method("get_state") and (child.get_state().get_name() == "Passive" \
			or child.get_state().get_name() == "Aggressive"):
			humans.append(child)
			child.get_state().connect("change_state", self, "human_infected", [child])
			human_count += 1

func get_zombies():
	return zombies

func human_infected(new_state, node):
	human_count -= 1
	zombies.append(node)
	set_label_text()
	if human_count <= 3:
		set_finish_text()
		timer.set_wait_time(5)
		timer.connect("timeout", self, "change_level")
		timer.start()

func set_label_text():
	if $LevelText/RemainingText:
		$LevelText/RemainingText.text = "- Humans Left to Meet: " + str(human_count)
		$LevelText/FinishText.text = "Level Complete! Time to socialize some more in " + str(timer.get_wait_time())
			
func set_finish_text():
	$LevelText/FinishText.text = "Level Complete! Time to socialize some more in " + str(timer.get_wait_time())
	$LevelText/FinishText.visible = true
	
func change_level():
	print("timer timed out")
	emit_signal("level_complete")
