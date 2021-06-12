extends Spatial

onready var state_machine = get_child(0)

export var starting_state = "Passive"

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.change_state(starting_state)
	
func get_current_state():
	return state_machine.get_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
