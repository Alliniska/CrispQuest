extends Control

var scenePath

#listens to button signals
func _ready():
	for button in $Menu/Buttons.get_children():
		button.connect("pressed", self, "on_Button_Pressed", [button.sceneToLoad])

#If a button is pressed fades screen and goes to desired screen
func on_Button_Pressed(sceneToLoad):
	scenePath = sceneToLoad
	if scenePath == "QUIT":
		get_tree().quit()
	$FadeIn.show()
	$FadeIn.fade_in()

#changes scene
func _on_FadeIn_transitionOver():
	var _success = get_tree().change_scene(scenePath)
