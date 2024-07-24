extends Resource
class_name GameData

@export var levels: Array[LevelData]
var current_level: int :
	set(value):
		current_level = clamp(value, 0, levels.size() - 1)
		if current_level != value:
			printerr("Tried to set level id outside bounds of loaded levels")

func get_current_level() -> LevelData:
	return levels[current_level]
