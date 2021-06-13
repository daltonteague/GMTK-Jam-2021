extends Node
class_name State

onready var blood_splash = preload("res://scenes/BloodSplash.tscn")
onready var host = get_parent().get_parent()
onready var anim_player = host.get_node("AnimationPlayer")
onready var tumble_magnitude = 1.5

onready var tumble_vector = Vector3(0, tumble_magnitude, 0)

onready var max_health : int = 1000
onready var current_health : int = max_health

signal change_state
signal infected(blood_splash, transform)

func enter():
	pass
	
func exit():
	pass
		
