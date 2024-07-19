extends GridContainer

var children: Array[LevelItem]
var selected: int : 
	set(value):
		children[selected].on_lowlight()
		selected = clamp(value, 0, children.size() - 1)
		children[selected].on_highlight()

func _ready():
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
		children[selected].load_level()

