extends BaseNPC

func _process(delta):
	run_from_zombies(delta)

func run_from_zombies(delta):
	if closest_zombie:
		host.add_force(move_vector * delta, tumble_vector)
		move_vector = -(closest_zombie.translation - host.translation).normalized() * run_speed
