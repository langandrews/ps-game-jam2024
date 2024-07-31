extends PickupGrabber

@onready var potion_slot = $"../../Camera2D/CanvasLayer/MarginContainer/PotionSlotBackground/PotionSlot"

func pickup(object):
	if object is Potion:
		SignalBus.PotionGrab.emit()
		object.position = Vector2.ZERO
		object.reparent(potion_slot, false)
