extends CharacterBody2D
class_name PlayerMovement

@export var max_horizontal_speed = 500
@export var max_vertical_speed = 5000
@export var acceleration = 50
@export var friction_factor = 0.8
@export var gravity = 20
@export var extra_gravity_multiplier = 2.0

@export var jump_velocity = 100

@onready var potion_slot = $Camera2D/CanvasLayer/MarginContainer/PotionSlotBackground/PotionSlot

var last_ground_touch_frame = -100000
var buffered_jump_frame = -100000
var jump_start_frame = -100000

var reset_timer = 0.0
var is_jumping = false
var is_dashing = false
var has_gravity = true
var is_double_jumping = false
var current_max_horizontal_speed = 0.0

var is_dead = false

func _ready():
	current_max_horizontal_speed = max_horizontal_speed
	SignalBus.DoubleJump.connect(double_jump)
	SignalBus.Dash.connect(dash)

func _physics_process(delta):
	handle_movement(delta)

func handle_movement(delta):
	if is_dead: return
	
	if Input.is_action_just_pressed("use_potion"):
		for child in potion_slot.get_children():
			if child is Potion:
				child.use(self)
				child.queue_free()
	
	update_coyote()
	
	if has_gravity:
		velocity.y += gravity * (extra_gravity_multiplier if velocity.y > 0 else 1.0)
		velocity.x *= friction_factor 
		
	if is_on_floor(): velocity.y = 0
	
	var input_horizontal := Input.get_axis("move_left", "move_right")
	velocity.x += (input_horizontal * acceleration)
	
	#if abs(input_horizontal) < 0.01 and is_on_floor():
	
	if is_double_jumping:
		is_double_jumping = false
		is_jumping = false
		velocity.y = -jump_velocity
	
	if velocity.y > 0: is_jumping = false
	if Input.is_action_just_pressed("jump"):
		if can_jump():
			jump()
		else:
			buffer_jump()
	elif is_buffered_jump() and can_jump():
		jump()
	elif not Input.is_action_pressed("jump") and is_jumping and not is_min_jump_window():
		velocity.y *= 0.1
		is_jumping = false
	
	if is_dashing:
		is_dashing = false
		has_gravity = false
		velocity.x = (jump_velocity if velocity.x >= 0 else -jump_velocity) * 1.5
		velocity.y = -5.0
		get_tree().create_timer(0.1).timeout.connect(func(): has_gravity = true)
	
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	velocity.y = clamp(velocity.y, -max_vertical_speed, max_vertical_speed)
	move_and_slide()

func jump():
	is_jumping = true
	velocity.y = -jump_velocity
	jump_start_frame = Engine.get_physics_frames()
	last_ground_touch_frame = -100000
	buffered_jump_frame = -1000000

func double_jump():
	is_double_jumping = true

func dash():
	is_dashing = true

func can_jump() -> bool:
	return is_coyote() || is_on_floor()

func is_coyote() -> bool:
	return Engine.get_physics_frames() - last_ground_touch_frame < 10

func update_coyote():
	if is_on_floor():
		last_ground_touch_frame = Engine.get_physics_frames()

func is_buffered_jump() -> bool:
	return Engine.get_physics_frames() - buffered_jump_frame < 15

func buffer_jump():
	buffered_jump_frame = Engine.get_physics_frames()

func is_min_jump_window():
	return Engine.get_physics_frames() - jump_start_frame < 6
