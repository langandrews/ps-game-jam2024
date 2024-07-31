extends Node2D
class_name PlayerDeath

@onready var animated_sprite_2d = $"../../Visuals/AnimatedSprite2D"
@onready var player = $"../.."

func death():
	SignalBus.Death.emit()
	player.is_dead = true
	animated_sprite_2d.rotate(PI/2)
	get_tree().create_timer(1.0).timeout.connect(reset_level)
	
func reset_level():
	SignalBus.ResetCurrentLevel.emit()
