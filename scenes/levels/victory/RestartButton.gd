extends Button

const LEVEL_SELECT = preload("res://scenes/ui/level_select.tscn")

func _pressed():
	SignalBus.LoadScene.emit(LEVEL_SELECT)
