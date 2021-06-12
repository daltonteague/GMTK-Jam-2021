extends Spatial

onready var bullet = preload("res://scenes/Bullet.tscn")



func _on_AnimationPlayer_animation_started(anim_name):
	var fired_bullet = bullet.instance()
	add_child(fired_bullet)
	fired_bullet.translation = $Flash.translation
	fired_bullet.enter()
