extends Node2D
class_name PlayerDeath

func death():
	SignalBus.ResetCurrentLevel.emit()
