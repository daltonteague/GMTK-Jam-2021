extends Node

signal start_button

# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/StartButton/AnimationPlayer.play("Hover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	print("start pressed")
	emit_signal("start_button")
