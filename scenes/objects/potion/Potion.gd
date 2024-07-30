extends Node2D
class_name Potion

var is_dark = false

func _ready():
	SignalBus.OnSwap.connect(func(new_val): is_dark = new_val)

func use():
	pass
