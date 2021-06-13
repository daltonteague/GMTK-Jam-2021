extends Spatial
class_name GameController

var zombies = []
var humans = []
var zombie_count = 0
var human_count = 0

var kills_left_goal = 0
var level_won = false

var timer
var finish_text = ""
var game_over_text = ""
var final_level = false

signal game_won
signal level_complete
signal level_failed

func enter(final_level):
	self.final_level = final_level
	
func _ready():
	count_zombies()
	count_humans()
	
func _process(delta):
	set_label_text()
	
func count_zombies():
	for child in get_children():
		if child.has_method("get_state") and child.get_state().get_name() == "Zombie":
			zombies.append(child)
			child.get_state().connect("zombie_dead", self, "zombie_dead")
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
	humans.erase(node)
	zombies.append(node)
	set_label_text()
	if human_count <= kills_left_goal:
		level_won = true
		if final_level:
			emit_signal("game_won")
			return
		activate_text($LevelText/Finish)
		start_timer(5.0)
		
func zombie_dead(node):
	zombie_count -= 1
	zombies.erase(node)
	if zombie_count <= 0:
		activate_text($LevelText/GameOver)
		start_timer(5.0)
		

func set_label_text():
	if $LevelText:
		$LevelText/RemainingText.text = "- Humans Left to Meet: " + str(human_count - kills_left_goal)
		if timer:
			$LevelText/Finish/FinishText.text = finish_text + get_time_left()
			$LevelText/GameOver/GameOverText.text = game_over_text + get_time_left()

func activate_text(node):
	for text in node.get_children():
		text.visible = true
	
func start_timer(seconds):
	timer = get_tree().create_timer(seconds)
	timer.connect("timeout", self, "change_level")

func get_time_left():
	return str(int(timer.get_time_left()))

func change_level():
	print("loading next level... " + str(level_won))
	if level_won:
		emit_signal("level_complete")
	else:
		emit_signal("level_failed")
