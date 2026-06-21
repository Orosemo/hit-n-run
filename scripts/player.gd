extends CharacterBody2D

@export var stats: Stats
@export var velocity_component: Velocity
@export var jump_buffer := 6
@export var coyote_time := 5
@export var gravity_mult := 0.5
@export var jump_factor := 0.5

@onready var right: ShapeCast2D = $right
@onready var left: ShapeCast2D = $left
@onready var anim_controller: AnimController = $AnimController

enum States {IDLE, WALKING, SPRINTING, FALLING, JUMP_PREPARE}

var jump_buffer_timer = null
var coyote_time_timer = null
var gravity_mult_timer = 1
var grav_timer = 0
var jump_strenght := 0.1
var jump_timer := 0

var state := States.IDLE

func change_state(new_state: States):
	# used for triggering stuff on specific states
	match new_state:
		States.IDLE:
			anim_controller.play_all("idle")
		States.WALKING:
			anim_controller.play_all("walk")
		States.FALLING:
			anim_controller.play_all("fall")

	# check for previous state
	match state:
		States.FALLING:
			gravity_mult_timer = 1

	state = new_state

func _process(delta):
	# midair funcs
	if not is_on_floor():
		# timers
		if not jump_buffer_timer == null:
			if jump_buffer_timer - 1 >= 0:
				jump_buffer_timer -= 1
			else:
				jump_buffer_timer = null

		if not coyote_time_timer == null:
			if coyote_time_timer - 1 >= 0:
				coyote_time_timer -= 1
			else:
				coyote_time_timer = 0

		# Add the gravity.
		if is_on_wall():
			velocity_component.add_velocity(get_gravity() * delta / 2)
		else:
			velocity_component.add_velocity(get_gravity() * delta * gravity_mult_timer)
		change_state(States.FALLING)
		if coyote_time_timer == null:
			coyote_time_timer = coyote_time

	else:
		if jump_buffer_timer != null:
			jump(stats.jump_velo)

		jump_buffer_timer = null
		coyote_time_timer = null

		if Input.is_action_just_pressed("jump"):
			change_state(States.JUMP_PREPARE)
		if Input.is_action_just_released("jump"):
			if jump_strenght <= 0.7:
				jump(stats.jump_velo)
			else:
				jump(stats.jump_velo * jump_strenght)
			jump_strenght = 0.5
			jump_timer = 0

	if state == States.FALLING:
		grav_timer += 1
		if grav_timer == 1000:
			gravity_mult_timer += gravity_mult
			grav_timer = 0

	if state == States.JUMP_PREPARE:
		print("yay")
		jump_timer += 1
		if jump_timer == 100:
			print("yay2")
			if not jump_strenght >= 1.2:
				jump_strenght += jump_factor
			else:
				jump_strenght = 1.2
				jump_timer = 0

	# wall jump
	if right.is_colliding() and Input.is_action_just_pressed("jump"):
		jump(stats.jump_velo / 2)
		
	elif left.is_colliding() and Input.is_action_just_pressed("jump"):
		jump(stats.jump_velo / 2)
		

	# Handle jump.
	if state != States.JUMP_PREPARE:
		if Input.is_action_just_pressed("jump") and coyote_time_timer != 0 and coyote_time_timer != null:
			jump(stats.jump_velo)
			coyote_time_timer = 0
		if Input.is_action_just_pressed("jump") and not is_on_floor():
			jump_buffer_timer = jump_buffer
		

	# handle left/right movement
	var direction := Input.get_axis("left", "right")
	if direction and state != States.JUMP_PREPARE:
		velocity_component.set_velocity_x(direction * stats.current_speed)
		change_state(States.WALKING)
			
		if direction < 0:
			anim_controller.set_direction_for_all(Vector2(-1, 1))
		else:
			anim_controller.set_direction_for_all(Vector2(1, 1))

	else:
		if not is_on_floor():
			velocity_component.reset_velocity_x(1)
		else:
			if state != States.JUMP_PREPARE:
				velocity_component.reset_velocity_x(stats.current_speed)
				change_state(States.IDLE)
	move_and_slide()

func jump(value: float):
	velocity_component.set_velocity_y(value)
	anim_controller.play_all("jump", true)
