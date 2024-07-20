extends Node2D

@export var offset = 400
@onready var player = $"../Player"
@onready var ground_tiles = $"../Ground Tiles"

var isCurrnetDark = false

func _ready():
	SignalBus.OnSwap.connect(swap)

func _physics_process(_delta):
	if not Input.is_action_just_pressed("swap_dimensions"): return
	
	var testPosition = player.position
	testPosition.y += get_offset(!isCurrnetDark)
	var tilePos = ground_tiles.local_to_map(testPosition)
	var tile = ground_tiles.get_cell_tile_data(1, tilePos)
	if tile: return
	
	SignalBus.OnSwap.emit(!isCurrnetDark)

func swap(isDark: bool):
	isCurrnetDark = isDark
	player.position.y += get_offset(isDark)

func get_offset(isDark: bool) -> int:
	return offset if isDark else -offset
	
