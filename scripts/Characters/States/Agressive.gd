extends BaseNPC

onready var gun = host.get_node("Rifle")
var gun_anim

func enter():
	current_health = 3000
	if gun:
		gun_anim = gun.get_node("AnimationPlayer")


func _process(delta):
	host.rotation.x = 0
	gun.translation = \
		Vector3(host.translation.x + 3, gun.translation.y, host.translation.z)
	
	if closest_zombie:
		host.look_at(closest_zombie.global_transform.origin, Vector3.UP)
#		host.rotate_y(deg2rad(180))
		gun.enter(closest_zombie)
		gun_anim.play("Fire")
	else:
		gun_anim.stop()
