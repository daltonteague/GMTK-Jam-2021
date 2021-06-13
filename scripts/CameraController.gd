extends Camera

func _process(delta):
	pass

func get_zombies():
	return get_tree().get_root().get_child(0).get_zombies()
