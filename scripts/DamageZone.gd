extends Area


var damage_amount = 20
var damage_body

func _process(delta):
	if damage_body:
		damage_body.take_damage(damage_amount)

func _on_Area_body_entered(body):
	print(body.get_name())
	if(body.has_method("get_state") and body.get_state().has_method("take_damage")):
		damage_body = body.get_state()

func _on_Area_body_exited(body):
	if body.get_state() == damage_body:
		damage_body = null
