extends CharacterBody2D


@export var stats: Stats
@export var jump_velo := -400.0
@export var velocity_component: Velocity

@onready var anim_controller: AnimController = $AnimController

enum States { IDLE, WALKING, SPRINTING, FALLING } 

var state := States.IDLE

func change_state (new_state: States):
	# used for triggering stuff on specific states'
	match new_state:
		States.IDLE:
			anim_controller.play_all("idle")
		States.WALKING:
			anim_controller.play_all("walk")
		States.FALLING:
			anim_controller.play_all("fall")
	state = new_state

func _process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		change_state(States.FALLING)
		

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity_component.set_velocity_y(jump_velo)
		anim_controller.play_all("jump", true)

	# handle left/right movement
	var direction := Input.get_axis("left", "right")
	if direction:
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
			velocity_component.reset_velocity_x(stats.current_speed)
			change_state(States.IDLE)
