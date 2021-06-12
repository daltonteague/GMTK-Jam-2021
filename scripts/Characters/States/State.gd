extends Node
class_name State

onready var host = get_parent().get_parent()
onready var max_speed = 2
onready var tumble_magnitude = 2

onready var tumble_vector = Vector3(0, tumble_magnitude, 0)

func enter():
	pass
	
func exit():
	pass
	
func _integrate_forces():
	if host.linear_velocity.length() > max_speed:
		host.linear_velocity = host.linear_velocity.normalized() * max_speed
		
