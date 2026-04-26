extends CharacterBody2D


@export var speed := 300.0
@export var springting_speed := 500.0
@export var jump_velo := -400.0
@export var velocity_component: Velocity

enum States { IDLE, WALKING, SPRINTING, FALLING } 

var state := States.IDLE

func change_state (new_state: States):
	# used for triggering stuff on specific states
	state = new_state

func _process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		change_state(States.FALLING)
	else:
		change_state(States.IDLE)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity_component.set_velocity_y(jump_velo)

	# handle left/right movement
	var direction := Input.get_axis("left", "right")
	if direction:
		if Input.is_action_pressed("run"):
			velocity_component.set_velocity_x(direction * springting_speed)
			change_state(States.SPRINTING)
		else:
			velocity_component.set_velocity_x(direction * speed)
			change_state(States.WALKING)

	else:
		if state == States.FALLING:
			velocity_component.reset_velocity_x(1)
		else:
			velocity_component.reset_velocity_x(speed)
