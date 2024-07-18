extends CharacterBody2D

@export var max_horizontal_speed = 400
@export var max_vertical_speed = 1000
@export var acceleration = 25
@export var friction_factor = 0.85
@export var gravity = 20
@export var extra_gravity_multiplier = 1.5

@export var jump_velocity = 1000


func _physics_process(delta):
	velocity.y += gravity * extra_gravity_multiplier if velocity.y else 1.0
	
	var input_horizontal := Input.get_axis("move_left", "move_right")
	velocity.x += (input_horizontal * acceleration)
	
	if abs(input_horizontal) < 0.01 and is_on_floor():
		velocity.x *= friction_factor 
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity
	elif Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.1
	
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	velocity.y = clamp(velocity.y, -max_vertical_speed, max_vertical_speed)
	move_and_slide()
