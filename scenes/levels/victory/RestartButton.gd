extends Button

const LEVEL_SELECT = preload("res://scenes/ui/level_select.tscn")

var is_enabled = 0

func _ready():
	get_tree().create_timer(0.5).timeout.connect(func(): is_enabled = true)

func _physics_process(_delta):
	if not is_enabled: return
	if Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("use_potion"):
		SignalBus.LoadScene.emit(LEVEL_SELECT)

func _pressed():
	SignalBus.LoadScene.emit(LEVEL_SELECT)
