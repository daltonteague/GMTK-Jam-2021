extends Node

func _on_Passive_infected(blood_splash, transform):
	splash(blood_splash, transform)

func _on_Zombie_infected(blood_splash, transform):
	splash(blood_splash, transform)

func splash(blood_splash, transform):
	var splash = blood_splash.instance()
	if get_tree():
		get_tree().get_root().get_child(0).add_child(splash)
	splash.global_transform = transform
	splash.rotation = Vector3.ZERO
	splash.emitting = true
	splash.restart()
