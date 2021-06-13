extends Spatial

onready var levels = [
	preload("res://scenes/Levels/CrabsInABucket.tscn"),
	preload("res://scenes/GameController.tscn")
]

var current_level_idx = 0
var current_level

func _ready():
	for level in levels:
		level.connect("level_complete", self, "next_level")
	next_level()
	
	
func next_level():
	print("beginning next level")
	if current_level:
		exit_prev_level()
	current_level_idx += 1
	current_level = levels[current_level_idx].instance()
	add_child(current_level)
	
func exit_prev_level():
	current_level.queue_free()
	
