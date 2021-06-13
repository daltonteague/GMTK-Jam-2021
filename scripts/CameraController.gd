extends Camera

func _process(delta):
	pass
	
onready var start_pos = get_camera_transform()
var last_avg = Vector3.ZERO

var smoothing_t = .94

func _process(delta):
	var average = Vector3()
	var zombies = get_zombies()
	
	for zombie in zombies:
		average += zombie.get_child(0).transform.origin
	
	average /= zombies.size()
	average = lerp(average, last_avg, smoothing_t)
	look_at_from_position(average + start_pos.origin, average, Vector3.UP)
	
	last_avg = average

func get_zombies():
	return get_tree().get_root().get_child(0).get_zombies()
