extends Button
export(String) var sceneToLoad

func _process(_delta):
	if is_hovered() == true:
		get_child(0).text = "Available in full game"
	else:
		get_child(0).text = "Continue"
