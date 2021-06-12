extends Node

func _on_Passive_infected(blood_splash, transform):
	var splash = blood_splash.instance()
	get_tree().get_root().get_node("World").add_child(splash)
	splash.global_transform = transform
	splash.rotation = Vector3.ZERO
	splash.emitting = true
	splash.restart()

