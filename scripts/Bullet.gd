extends KinematicBody

export var DAMAGE = 200

onready var timer = $Timer
onready var explosion_particles = $ExplosionParticles
onready var collider = $Shot

var speed = 100
var velocity = Vector3()
var despawn_time = 5

func enter():
	timer.set_wait_time(despawn_time)
	timer.start()
	velocity = -transform.basis.z.normalized() * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()

func _on_Timer_timeout():
		queue_free()

func _on_Area_body_entered(body):
	if body.has_method("get_state") and body.get_state().has_method("take_damage"):
		body.take_damage(DAMAGE)
		queue_free()

	
