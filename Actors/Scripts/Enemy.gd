extends "res://Actors/Scripts/Actor.gd"

# Node references
var player
var navigation

#for astar pathfinding
var path
const POINT_RADIUS = 5

# Random number generator
var rng = RandomNumberGenerator.new()

# Movement variables
var direction : Vector2

#AI variables
var lastPosition
var stuck = false #if character is supposed to be chasing enemy and not attempt to change direction or stand still
var idling = true # if character is supposed to be standing still
var lastDirection = Vector2(0, 1)
var bounce_countdown = 0

#animation
onready var sprite = get_node("sprite")

func _ready():
	player = get_node('../../../../Player')
	navigation = get_node("../../GroundMap")
	rng.randomize()

func _physics_process(_delta):
	#move
	var velocity = direction * speed
	var _move = move_and_slide(velocity)

	#in case he gets stuck he wobbles to get unstuck
	if lastPosition != null and (lastPosition - global_position).length() < 0.1 and stuck == true:
		global_position.x += direction.y * 2
		global_position.y -= direction.x * 2
	#character bumped into wall while moving and will attempt to change direction
	elif lastPosition != null and (lastPosition - global_position).length() < 0.1 and idling == false:
		idleBehaviour()
	#remove path bit when theyre moved into or gone
	if global_position.distance_to(player.position) < POINT_RADIUS:
		if path:
			path.remove(0)
			if path.size() == 0:
				path = null
	lastPosition = global_position
	if direction != Vector2.ZERO:
		lastDirection = direction
	animate()

func animate():
#	#runs appropriate idle animationw
	if direction == Vector2.ZERO:
		if lastDirection == Vector2(0,1):
			sprite.play("idleDown")
		elif lastDirection == Vector2(0,-1):
			sprite.play("idleUp")
		elif lastDirection == Vector2(1,0):
			sprite.play("idleRight")
		elif lastDirection == Vector2(-1,0):
			sprite.play("idleLeft")
	else:
		if direction == Vector2(0,1):
			sprite.play("runningDown")
		elif direction == Vector2(0,-1):
			sprite.play("runningUp")
		elif direction == Vector2(1,0):
			sprite.play("runningRight")
		elif direction == Vector2(-1,0):
			sprite.play("runningLeft")

func _on_BehaviourTimer_timeout():
	#get distance between player and enemy
	var playerPosition = player.position - global_position
	if playerPosition.length() <= 32:
		direction = Vector2.ZERO
		stuck = false
		idling = true
	elif playerPosition.length() <= 200 and bounce_countdown == 0:
		chasingBehaviour()
	else:
		idleBehaviour()

func idleBehaviour():
	speed = Vector2(50,50)
	var random = rng.randf()
	if random < 0.05:
		idling = true
		direction = Vector2.ZERO
		stuck = false
		
	elif random < 0.1:
		idling = false
		var change = false
		while change == false:
			var newDirection = Vector2.ZERO
			var randomDice = rng.randi()%4+1
			if randomDice == 1:
				newDirection = Vector2(1,0)
			elif randomDice == 2:
				newDirection = Vector2(-1,0)
			elif randomDice == 3:
				newDirection = Vector2(0,-1)
			else:
				newDirection = Vector2(0,1)
			if direction != newDirection:
				direction = newDirection
				change = true


func chasingBehaviour():
	speed = Vector2(100,100)
	stuck = true
	idling = false
	path = navigation.get_path_thing(global_position, player.position)
	if path:
		path.remove(0)
#if enemy has a path
	if path:
		var goal = path[0] #make player path endpoint
#		# Determine direction
		direction = (goal - global_position).normalized()
#	#limits movement to left,right,up,down
	else:
		direction = (player.position - global_position).normalized()
	if abs(direction.x) > abs(direction.y):
		direction = Vector2(sign(direction.x), 0)
	else:
		direction = Vector2(0, sign(direction.y))

