extends Node2D

const LEVEL_SELECT = preload("res://scenes/ui/level_select.tscn")

func _ready():
	SignalBus.LoadScene.connect(loadScene)
	loadScene(LEVEL_SELECT)

func loadScene(scene: PackedScene):
	for child in get_children():
		child.queue_free()
	var new_scene = scene.instantiate()
	add_child(new_scene)
