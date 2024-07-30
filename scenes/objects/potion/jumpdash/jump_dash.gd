extends Potion

func use():
	if is_dark:
		SignalBus.Dash.emit()
	else:
		SignalBus.DoubleJump.emit()
