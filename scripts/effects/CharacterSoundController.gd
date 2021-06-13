extends Node

onready var pop = preload("res://sounds/pop_sound.wav")

var hurt_sounds = [
	preload("res://sounds/hurt_sounds/hurt1.wav"),
	preload("res://sounds/hurt_sounds/hurt2.wav"),
	preload("res://sounds/hurt_sounds/hurt3.wav"),
	preload("res://sounds/hurt_sounds/hurt4.wav")
]

var rare_hurt_sound = preload("res://sounds/hurt_sounds/hurt5.wav")

func _on_Passive_infected(blood_splash, transform):
	play_sound(pop)

func _on_Aggressive_infected(blood_splash, transform):
	play_sound(pop)

# This is really just on_zombie_hit
func _on_Zombie_infected(blood_splash, transform):
	var rng = randi() % 41
	var hurt_sound
	if rng == 41:
		hurt_sound = rare_hurt_sound
	else:
		var idx = rng % hurt_sounds.size()
		hurt_sound = hurt_sounds[idx]
		
	play_sound(hurt_sound)


func play_sound(sound):
	var player = AudioStreamPlayer3D.new()
	player.set_stream(sound)
	self.add_child(player)
	player.set_unit_size(100.0)
	player.play(0.0)
