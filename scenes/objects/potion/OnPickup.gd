extends Area2D

func _on_area_entered(area):
	for child in area.get_children():
		if child is PickupGrabber:
			child.pickup(get_parent())
