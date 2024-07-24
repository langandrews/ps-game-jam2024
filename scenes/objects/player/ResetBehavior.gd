extends ProgressBar

@export var reset_hold_duration_seconds = 1.5

var reset_timer = 0.0
var can_reset = false

func _ready():
	modulate.a = 0

func _physics_process(delta):
	handle_reset(delta)

func handle_reset(delta):
	if Input.is_action_just_pressed("reset"):
		can_reset = true
	if !can_reset: return
	if Input.is_action_pressed("reset"):
		reset_timer += delta
		if reset_timer >= reset_hold_duration_seconds:
			SignalBus.ResetCurrentLevel.emit()
	else:
		reset_timer = maxf(reset_timer - delta - delta, 0.0)
	
	value = lerpf(0.0, 1.0, reset_timer / reset_hold_duration_seconds)
	modulate.a = minf(value * 2, 1.0)
