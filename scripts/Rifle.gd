extends Spatial

onready var bullet = preload("res://scenes/Bullet.tscn")

var target

func enter(target):
	self.target = target

func _on_AnimationPlayer_animation_started(anim_name):
	if target:
		var fired_bullet = bullet.instance()
		add_child(fired_bullet)
		fired_bullet.transform = $Flash.transform
		fired_bullet.look_at(target.global_transform.origin, Vector3.UP)
		fired_bullet.enter()
