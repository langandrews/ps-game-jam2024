extends Node
class_name LevelItem

@export var text: String = "1"

@export var is_complete: bool = false

@onready var completed_icon = $MarginContainer/CompletedIcon

@onready var background = $Background
@onready var label = $MarginContainer/Label

func _ready():
	on_lowlight()
	completed_icon.visible = is_complete
	label.text = text

func on_highlight():
	background.modulate.a = 1

func on_lowlight():
	background.modulate.a = 0
