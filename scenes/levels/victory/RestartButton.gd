extends Button

const LEVEL_SELECT = preload("res://scenes/ui/level_select.tscn")

func _physics_process(_delta):
	if Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("use_potion"):
		SignalBus.LoadScene.emit(LEVEL_SELECT)

func _pressed():
	SignalBus.LoadScene.emit(LEVEL_SELECT)
