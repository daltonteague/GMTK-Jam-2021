extends Spatial

onready var bullet = preload("res://scenes/Bullet.tscn")

var target
var i = 0

func enter(target):
	self.target = target

# Called from Animation Player
func spawn_bullet():
	if target:
		var fired_bullet = bullet.instance()
		get_tree().get_root().get_child(0).add_child(fired_bullet)
		fired_bullet.global_transform.origin = $Flash.global_transform.origin
		fired_bullet.look_at(target.global_transform.origin, Vector3.UP)
		fired_bullet.enter()
