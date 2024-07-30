extends Potion

const DUST = preload("res://scenes/objects/potion/jumpdash/dust.tscn")

@export var is_dark_dash := true

func use(user: Node2D):
	var vfx := DUST.instantiate()
	vfx.position = user.position + Vector2(0, -8)
	vfx.emitting = true
	user.get_parent().add_child(vfx)
	
	if is_dark == is_dark_dash:
		SignalBus.Dash.emit()
		if user is CharacterBody2D:
			vfx.rotate(-PI / 2.0 if user.get_real_velocity().x < 0 else PI / 2.0)
	else:
		SignalBus.DoubleJump.emit()
