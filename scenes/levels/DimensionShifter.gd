extends Node2D

@export var offset = 400
@onready var player = $"../Player"
@onready var ground_tiles = $"../Ground Tiles"

var isCurrnetDark = false
var offsets := [
	Vector2(0, 0),
	Vector2(4, 0),
	Vector2(-4, 0),
	Vector2(0, 4),
	Vector2(0, -4),
]

func _ready():
	SignalBus.OnSwap.connect(swap)

func _physics_process(_delta):
	if not Input.is_action_just_pressed("swap_dimensions"): return
	
	var testPosition = player.position
	testPosition.y += get_offset(!isCurrnetDark) - 8
	for offset in offsets:
		var tilePos = ground_tiles.local_to_map(testPosition + offset)
		var tile = ground_tiles.get_cell_tile_data(1, tilePos)
		var isEmpty = tile == null
		if isEmpty:
			SignalBus.OnSwap.emit(!isCurrnetDark)
			return
	
	

func swap(isDark: bool):
	isCurrnetDark = isDark
	player.position.y += get_offset(isDark)

func get_offset(isDark: bool) -> int:
	return offset if isDark else -offset
	
