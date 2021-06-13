extends Node

onready var pop = preload("res://sounds/pop_sound.wav")

func _on_Passive_infected(blood_splash, transform):
	var player = AudioStreamPlayer3D.new()
	player.set_stream(pop)
	self.add_child(player)
	player.set_unit_size(100.0)
	player.play(0.0)
	print("pop")
