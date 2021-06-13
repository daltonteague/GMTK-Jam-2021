extends GameController


func enter(final_level):
	.enter(final_level)
	finish_text = "Level Complete! Ready to expand the social circle in "
	game_over_text = "I guess humans prefer handshakes to handbites... Who could have known? Try again in "
	kills_left_goal = 10
	$LevelText/RichTextLabel.text = "Humans with guns. How fun!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
