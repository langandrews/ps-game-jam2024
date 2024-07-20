extends Node2D

@export var offset = 400
@onready var player = $"../Player"

var isCurrnetDark = false

func _ready():
	SignalBus.OnSwap.connect(swap)

func _physics_process(_delta):
	if Input.is_action_just_pressed("swap_dimensions"):
		SignalBus.OnSwap.emit(!isCurrnetDark)

func swap(isDark: bool):
	isCurrnetDark = isDark
	player.position.y += offset if isDark else -offset
	
