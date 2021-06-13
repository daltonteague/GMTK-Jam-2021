extends Spatial

onready var levels = [
	preload("res://scenes/Levels/CrabsInABucket_camera.tscn"),
	preload("res://scenes/Levels/LevelTwo.tscn"),
	preload("res://scenes/Levels/LevelThree.tscn")
]

onready var start_menu = $StartMenu
var victory_menu
var start_menu_scene = preload("res://scenes/StartMenu.tscn")
var victory_menu_scene = preload("res://scenes/VictoryMenu.tscn")
onready var game_complete_menu = $VictoryMenu

var current_level_idx = 0
var current_level

func _ready():
	print("starting game")
	start_menu.connect("start_button", self, "start_game")
	
func start_game():
	print("got start signal")
	start_menu.queue_free()
	next_level()
	
func next_level():
	print("beginning next level")
	exit_prev_level()
	current_level = levels[current_level_idx].instance()
	current_level.connect("game_won", self, "game_won")
	current_level.connect("level_complete", self, "next_level")
	current_level.connect("level_failed", self, "restart")
	add_child(current_level)
	var final_level = current_level_idx == levels.size() - 1
	current_level.enter(final_level)
	current_level_idx += 1
	
func restart():
	current_level_idx = 0
	next_level()
	
func game_won():
	print("Got game won signal")
	exit_prev_level()
	victory_menu = victory_menu_scene.instance()
	add_child(victory_menu)
	victory_menu.connect("restart_button", self, "restart_game")
	
func restart_game():
	current_level_idx = 0
	start_menu = start_menu_scene.instance()
	victory_menu.queue_free()
	remove_child(victory_menu)
	add_child(start_menu)
	start_menu.connect("start_button", self, "start_game")
	
func exit_prev_level():
	if current_level:
		current_level.queue_free()
		remove_child(current_level)
		current_level = null
	
