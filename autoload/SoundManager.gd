extends Node

@onready var swap_sound = $SwapSound

func _ready():
	SignalBus.OnSwap.connect(play_swap_sound)

func play_swap_sound(is_dark: bool):
	var dark_pitch = randf_range(0.9, 1.0)
	var light_pitch = randf_range(1.0, 1.1)
	
	var pitch = dark_pitch if is_dark else light_pitch
	
	swap_sound.pitch_scale = pitch
	swap_sound.play()
	pass
