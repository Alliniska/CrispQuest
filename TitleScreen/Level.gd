extends Node2D
var levelLoad = preload("res://Levels/DeluxeStore.tscn")
var currentLevel
var playerPosition = Vector2(100,100)
var loading = false
func _init():
	currentLevel = levelLoad.instance()
	add_child(currentLevel)

func _ready():
	currentLevel = get_child(0)
	currentLevel.connect("switchLevel", self, "on_Level_switchLevel")
	
func _physics_process(_delta):
	if loading == true:
		levelLoad = currentLevel.path
		print(levelLoad)
		currentLevel.queue_free()
		currentLevel = load(levelLoad).instance()
		currentLevel.connect("switchLevel", self, "on_Level_switchLevel")
		add_child(currentLevel)
		get_parent().get_child(1).position = playerPosition
		loading = false

func on_Level_switchLevel():
	if loading == false:
		loading = true
		
