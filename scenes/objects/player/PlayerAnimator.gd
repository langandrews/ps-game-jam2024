extends AnimatedSprite2D

func _ready():
	SignalBus.OnSwap.connect(changeSprite)

func changeSprite(isDark):
	animation = "dark" if isDark else "light"
