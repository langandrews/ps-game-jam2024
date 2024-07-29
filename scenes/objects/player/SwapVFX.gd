extends TextureRect

func _ready():
	SignalBus.OnSwap.connect(swap)
	update_shader(0.0)

func swap(_isDark):
	var tween := get_tree().create_tween()
	tween.tween_method(update_shader, 0.0, 1.0, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): update_shader(0.0))

func update_shader(value: float):
	var size = lerpf(0.0, 2.5, value)
	var width = lerpf(0.05, 0.75, value)
	var force = lerpf(0.015, 0.1, value)
	var shader = material as ShaderMaterial
	shader.set_shader_parameter("size", size)
	shader.set_shader_parameter("width", width)
	shader.set_shader_parameter("force", force)
