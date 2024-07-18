extends Node
class_name LevelItem

@export var text: String = "1"
@export var level_scene: PackedScene

@onready var background = $Background
@onready var label = $MarginContainer/Label

func _ready():
	on_lowlight()
	label.text = text

func on_highlight():
	background.modulate.a = 1

func on_lowlight():
	background.modulate.a = 0

func load_level():
	SignalBus.LoadScene.emit(level_scene)
