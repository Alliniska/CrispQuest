extends Area2D

#contains data for level transition
export(String, FILE, "*tscn") var nextScene
signal changeLevel

#emits signal to change level
func _on_ChangeScene_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	if "Player" in body.name:
		emit_signal("changeLevel")
