tool
extends TextureProgress

#initialize values
func initialize(current, maximum):
	max_value = maximum
	value = current

#get player node when loaded and listen for signal
func _ready():
	var player = get_node("../../../Player")
	player.connect("experienceGained", self, "_on_Player_experienceGained")
	
#when signal recieved
func _on_Player_experienceGained(growthData):
	#interpret data
	for line in growthData:
		var targetExperience = line[0]
		var maxExperience = line[1]
		
		#animate bar
		max_value = maxExperience
		yield(animate_value(targetExperience), "completed")
		if abs(max_value - value) < 0.01:
			value = 0

#uses tween to animate bar
func animate_value(target, tweenDuration = 1.0):
	$Tween.interpolate_property(self, 'value', value, target, tweenDuration, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
