extends Node

#const combatArenaScene = preload("res://CombatArena/combatArena.tscn")
onready var _player = $Player
onready var _label = $CanvasLayer/WorldGUI/Portrait/Label
onready var _experience = $CanvasLayer/WorldGUI/ExperienceBar/ExpLabel
onready var _bar = $CanvasLayer/WorldGUI/ExperienceBar

#gets playerdata
func _ready():
	_bar.initialize(_player.experience, _player.experienceReq)
	_label.update_text(_player.level)
	_experience.update_text(_player.experience, _player.experienceReq)

#levels up player cheat way
func _input(event):
	if not event.is_action_pressed("ui_accept"):
		return
	_player.gain_exp(10)
	_label.update_text(_player.level)
	_experience.update_text(_player.experience, _player.experienceReq)
