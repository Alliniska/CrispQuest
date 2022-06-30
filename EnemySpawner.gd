extends Node

export(PackedScene) var enemyPattern
func _ready():
	var child = enemyPattern.instance()
	add_child(child)

func _on_Timer_timeout():
	if self.get_child_count() <= 2:
		var child = enemyPattern.instance()
		add_child(child)
