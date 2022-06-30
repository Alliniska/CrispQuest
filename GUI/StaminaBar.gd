tool
extends TextureProgress

func initialize(current, maximum):
	max_value = maximum
	value = current

func _ready():
	var player = get_node("../../../Player")
#	player.connect("staminaChange", self, "_on_Player_staminaChange")
	
func _on_Player_staminaChange(staminaData):
	pass

func animate_value(target, tweenDuration = 1.0):
	$Tween.interpolate_property(self, 'value', value, target, tweenDuration, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
