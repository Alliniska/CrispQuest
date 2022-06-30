extends KinematicBody2D
class_name Actor

export var speed: = Vector2(100,100)
export var velocity: = Vector2.ZERO

signal experienceGained(growth_data)

#stats
export var strength = 0
export var intelligence = 0
export var agility = 0
export var hpMax = 1
export var stamina = 1

#levelling
var maxLevel: = 10
export var experience = 0
var experienceTotal = 0
export (int) var level = 1
var experienceReq = get_req_exp(level + 1)

func _physics_process(_delta: float) -> void:
	velocity = velocity.normalized() * speed #makes sure that the speed is always the same
	velocity = move_and_slide(velocity)

#calculates expereince using maths expression
func get_req_exp(levelCalculator):
	return round(pow(levelCalculator, 1.8) + levelCalculator * 4 + 5)

#adds exp and checks for levelup
func gain_exp(amount):
	experienceTotal += amount
	experience += amount
	var growthData = []
	while experience >= experienceReq:
		experience -= experienceReq
		growthData.append([experienceReq, experienceReq])
		level_up()
	growthData.append([experience, experienceReq])
	emit_signal("experienceGained", growthData)

func level_up():
	level += 1
	experienceReq = get_req_exp(level + 1)
	#increase stats block here (rand func?)
	
	var stats = ['strength', 'intelligence', 'agility', 'hpMax', 'stamina']
	var randomStat = stats[randi() % stats.size()]
	set(randomStat, get(randomStat) + randi() % 6 + 3)
