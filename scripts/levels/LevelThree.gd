extends GameController


func enter(final_level):
	.enter(final_level)
	finish_text = "Level Complete! Time to socialize some more in "
	game_over_text = "I guess humans prefer handshakes to handbites... Who could have known? Try again in "
	kills_left_goal = 25
	$LevelText/RichTextLabel.text = "Now this is a party!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
