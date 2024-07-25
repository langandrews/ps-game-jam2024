extends Area2D

func _on_area_entered(area):
	var body = area.get_parent()
	if body is PlayerMovement and body.get_real_velocity().y > 0:
		for child in area.get_children():
			if child is PlayerDeath:
				child.death()
