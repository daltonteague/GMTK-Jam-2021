extends Node

signal restart_button

# Called when the node enters the scene tree for the first time.
func _ready():
	$RestartButton/AnimationPlayer.play("Hover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RestartButton_pressed():
	print("start pressed")
	emit_signal("restart_button")
