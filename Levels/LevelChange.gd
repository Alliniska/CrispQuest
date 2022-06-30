extends Node2D
signal switchLevel
var path
var changer1
var changer2

func _ready():
	changer1 = get_child(2)
	changer1.connect("changeLevel", self, "_on_ChangeScene_changeLevel", [changer1.nextScene])

func _on_ChangeScene_changeLevel(nextScene):
	path = nextScene
	emit_signal("switchLevel")

