extends GridContainer

const LEVEL_ITEM = preload("res://scenes/ui/level_item.tscn")

var children: Array[LevelItem]
var selected: int : 
	set(value):
		children[selected].on_lowlight()
		selected = clamp(value, 0, children.size() - 1)
		children[selected].on_highlight()

func _ready():
	for i in range(Global.game_data.levels.size()):
		var level = Global.game_data.levels[i]
		var level_selection = LEVEL_ITEM.instantiate()
		level_selection.text = str(i + 1)
		level_selection.is_complete = level.is_cleared
		add_child(level_selection)
	children.assign(get_children())
	selected = 0

func _physics_process(_delta):
	if Input.is_action_just_pressed("move_left"):
		selected -= 1
	if Input.is_action_just_pressed("move_right"):
		selected += 1
	if Input.is_action_just_pressed("move_up"):
		selected -= columns
	if Input.is_action_just_pressed("move_down"):
		selected += columns
	
	if Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("use_potion"):
		Global.game_data.current_level = selected
		SignalBus.LoadScene.emit(Global.game_data.levels[selected].scene)

