extends Control

#shows transition on mouse click
func _input(event):
	if event is InputEventMouseButton:
		$Transition.show()
		$Transition.fade_in()

#moves back to title
func _on_Transition_transitionOver():
	get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
