extends Node

onready var states = {
	"Passive" : $States/Passive,
	"Zombie" : $States/Zombie,
	"Aggressive" : $States/Aggressive,
	"Dead" : $States/Dead
}

var current_state

func _ready():
	for state in states:
		states[state].connect("change_state", self, "change_state")
		exit_state(states[state])

func set_braking(is_braking):
	self.is_braking = is_braking
	
func get_state():
	return current_state
	
func change_state(next_state):
	print(get_parent().get_name() + " changing state " + next_state) 
	var prev_state = current_state
	if next_state:
		current_state = states[next_state]
	if prev_state:
		exit_state(prev_state)
	enter_state(current_state)
	
func enter_state(state):
	state.set_process(true)
	state.set_physics_process(true)
	state.enter()
	
func exit_state(state):
	state.set_process(false)
	state.set_physics_process(false)
	state.exit()

##### RigidBody Specific Code that has to go here #########
onready var max_speed = 40

func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
