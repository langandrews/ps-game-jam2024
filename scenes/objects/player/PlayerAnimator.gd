extends AnimatedSprite2D

var is_dark = false
var current_animation_id = "idle"
@onready var player = $"../.."

func _ready():
	SignalBus.OnSwap.connect(changeSprite)

func _process(delta):
	if player.is_on_floor():
		if abs(player.get_real_velocity().x) < 0.1:
			idle()
		else:
			face_direction(player.get_real_velocity().x > 0)
			run()
	else:
		jump()

func face_direction(is_left: bool):
	if flip_h != is_left: return
	flip_h = !is_left

func jump():
	if current_animation_id == "jump": return
	current_animation_id = "jump"
	update_animation_state()

func idle():
	if current_animation_id == "idle": return
	current_animation_id = "idle"
	update_animation_state()

func run():
	if current_animation_id == "run": return
	current_animation_id = "run"
	update_animation_state()

func build_animation_name() -> String:
	return current_animation_id + "_" + str("dark" if is_dark else "light")

func changeSprite(isDark):
	is_dark = isDark
	update_animation_state()

func update_animation_state():
	var current_frame = frame
	var current_progress = frame_progress
	animation = build_animation_name()
	set_frame_and_progress(current_frame, current_progress)
