extends Node2D

@export var dark_offset := Vector2(0, 400)
@onready var player = $"../Player"
@onready var ground_tiles = $"../Ground Tiles"

@export var buffer_window_seconds := 0.25
@export var swap_cooldown_seconds := 0.2
var buffer_frame = -10000000
var last_swap_frame = 0

var isCurrnetDark = false
var offsets := [
	Vector2(0, 0),
	Vector2(2, 0),
	Vector2(-2, 0),
	Vector2(0, 2),
]

func _ready():
	SignalBus.OnSwap.connect(swap)

func _physics_process(_delta):
	if Input.is_action_just_pressed("swap_dimensions"):
		update_buffer()
	elif not is_buffering(): return
	
	var frames_since_last_swap = Engine.get_physics_frames() - last_swap_frame
	if frames_since_last_swap < swap_cooldown_seconds * Engine.physics_ticks_per_second:
		return
	
	var testPosition = player.position
	testPosition += get_offset(!isCurrnetDark) - Vector2(0, 8)
	for offset in offsets:
		var tilePos = ground_tiles.local_to_map(testPosition + offset)
		var tile = ground_tiles.get_cell_tile_data(1, tilePos)
		var isEmpty = tile == null
		if isEmpty:
			SignalBus.OnSwap.emit(!isCurrnetDark)
			buffer_frame = -1000000
			last_swap_frame = Engine.get_physics_frames()
			return

func swap(isDark: bool):
	isCurrnetDark = isDark
	player.position += get_offset(isDark)

func get_offset(isDark: bool) -> Vector2:
	return dark_offset if isDark else -1 * dark_offset

func update_buffer():
	buffer_frame = Engine.get_physics_frames()

func is_buffering() -> bool:
	return Engine.get_physics_frames() - buffer_frame < buffer_window_seconds * Engine.physics_ticks_per_second
