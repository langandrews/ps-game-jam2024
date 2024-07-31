extends Node

@onready var swap_sound = $SwapSound
@onready var jump_sound = $JumpSound
@onready var dash_sound = $DashSound
@onready var death_sound = $DeathSound

@onready var music_main = $MusicMain
@onready var music_other = $MusicOther

var is_first_grab = true

func _ready():
	SignalBus.OnSwap.connect(play_swap_sound)
	SignalBus.Dash.connect(func(): play_dash_sound(true))
	SignalBus.DoubleJump.connect(func(): play_dash_sound(false))
	SignalBus.Death.connect(play_death_sound)
	SignalBus.PotionGrab.connect(play_potion_grab)
	SignalBus.Jumped.connect(play_jump_sound)

func play_swap_sound(is_dark: bool):
	var dark_pitch = randf_range(0.9, 1.0)
	var light_pitch = randf_range(1.0, 1.1)
	
	var pitch = dark_pitch if is_dark else light_pitch
	
	swap_sound.pitch_scale = pitch
	swap_sound.play()

func play_jump_sound():
	jump_sound.pitch_scale = randf_range(0.95, 1.05)
	jump_sound.play()

func play_dash_sound(is_low: bool):
	var low_pitch = randf_range(0.9, 1.0)
	var high_pitch = randf_range(1.0, 1.1)
	
	var pitch = low_pitch if is_low else high_pitch
	
	dash_sound.pitch_scale = pitch
	dash_sound.play()

func play_death_sound():
	death_sound.pitch_scale = randf_range(0.95, 1.05)
	death_sound.play()

func play_potion_grab():
	if is_first_grab:
		is_first_grab = false
		swap_music()
	
	death_sound.pitch_scale = randf_range(0.95, 1.05)
	death_sound.play()

func swap_music():
	music_main.stop()
	music_other.play()
