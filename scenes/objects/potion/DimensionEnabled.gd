extends Sprite2D

@export var is_dark := false

func _ready():
	visible = !is_dark
	SignalBus.OnSwap.connect(change)

func change(is_now_dark):
	visible = is_dark == is_now_dark
