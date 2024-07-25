extends Area2D

func _on_area_entered(area):
	print("body entered spikes")
	var body = area.get_parent()
	print(body.velocity.y)
	print(body.name)
	if body is PlayerMovement and body.velocity.y > 0:
		for child in area.get_children():
			print("child")
			print(str(child))
			if child is PlayerDeath:
				child.death()
