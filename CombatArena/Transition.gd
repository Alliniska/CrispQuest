extends Control

signal transitionOver

#plays animation
func fade_in():
	$ColorRect/AnimationPlayer.play("FadeIn")

#signals animation is over
func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("transitionOver")

