extends Node2D

const VICTORY = preload("res://scenes/levels/victory/victory.tscn")

func onCollected(_area: Area2D):
	Global.game_data.get_current_level().is_cleared = true
	
	if Global.game_data.current_level + 1 >= Global.game_data.levels.size():
		SignalBus.LoadScene.emit(VICTORY)
		return
	
	Global.game_data.current_level += 1
	SignalBus.LoadScene.emit(Global.game_data.get_current_level().scene)
