extends "res://Actors/Scripts/Actor.gd"

#variable declarations
#Sprite
var facing = "down"
var animation = "idle"
onready var playerSprite = get_node("sprite") #gets character sprite resource
var no = 0

func _physics_process(_delta: float) -> void:
	#gets direction data
	var dir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0
	)
	if dir.x == 0:
		dir = Vector2(
			0, Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
	set_dir(dir)
	#moves sprite
	velocity = speed * dir

	#runs appropriate walking animation
	if facing == "down":
		animation = "runDown"
	elif facing == "up":
		animation = "runUp"
	elif facing == "right":
		animation = "runRight"
	elif facing == "left":
		animation = "runLeft"
	
	#runs appropriate idle animation
	if velocity.x == 0 and velocity.y == 0:
		if facing == "down":
			animation = "idleDown"
		elif facing == "up":
			animation = "idleUp"
		elif facing == "right":
			animation = "idleRight"
		elif facing == "left":
			animation = "idleLeft"
	
	#plays set animation
	playerSprite.play(animation)

#tells program which direction is being faced
func set_dir(dir):
	if dir.x != 0 or dir.y != 0:
		if dir.x > 0:
			facing = "right"
		elif dir.x < 0:
			facing = "left"
		elif dir.y > 0:
			facing = "down"
		else:
			facing = "up"
