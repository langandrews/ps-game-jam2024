extends CharacterBody2D

@export var max_horizontal_speed = 500
@export var max_vertical_speed = 5000
@export var acceleration = 50
@export var friction_factor = 0.8
@export var gravity = 20
@export var extra_gravity_multiplier = 2.0

@export var jump_velocity = 900

var last_ground_touch_frame = -100000
var buffered_jump_frame = -100000
var jump_start_frame = -100000

func _physics_process(delta):
	update_coyote()
	
	velocity.y += gravity * extra_gravity_multiplier if velocity.y else 1.0
	
	var input_horizontal := Input.get_axis("move_left", "move_right")
	velocity.x += (input_horizontal * acceleration)
	
	if abs(input_horizontal) < 0.01 and is_on_floor():
		velocity.x *= friction_factor 
	
	if Input.is_action_just_pressed("jump"):
		if can_jump():
			jump()
		else:
			buffer_jump()
	elif is_buffered_jump() and can_jump():
		jump()
	elif not Input.is_action_pressed("jump") and velocity.y < 0 and not is_min_jump_window():
		velocity.y *= 0.1
	
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	velocity.y = clamp(velocity.y, -max_vertical_speed, max_vertical_speed)
	move_and_slide()

func jump():
	velocity.y = -jump_velocity
	jump_start_frame = Engine.get_physics_frames()
	last_ground_touch_frame = -100000
	buffered_jump_frame = -1000000

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
