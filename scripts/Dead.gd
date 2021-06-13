extends State

export var dead_skin : Material 

func enter():
	change_skin(dead_skin)
	anim_player.play("Death")
	.enter()

func change_skin(material):
	host.get_node("Skin").get_mesh().surface_set_material(0, material)
