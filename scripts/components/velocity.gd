extends Node
class_name Velocity

@export var characterbody: CharacterBody2D

# states
var confused = false
var shocked = false

# flags
var freeze = false

# set velocities
func set_velocity(direction: Vector2):
	if not freeze:
		if not confused:
			characterbody.velocity.x = direction.x
			characterbody.velocity.y = direction.y
		else:
			characterbody.velocity.x = -direction.x
			characterbody.velocity.y = direction.y
	else:
		characterbody.velocity = Vector2(0, 0)
	characterbody.move_and_slide()

func set_velocity_x(speed: float):
	if not freeze:
		if not confused:
			characterbody.velocity.x = speed
		else:
			characterbody.velocity.x = -speed
	else:
		characterbody.velocity = Vector2(0, characterbody.velocity.y)
	characterbody.move_and_slide()

func set_velocity_y(speed: float):
	if not freeze:
		characterbody.velocity.y = speed
	else:
		characterbody.velocity = Vector2(characterbody.velocity.x, 0)
	characterbody.move_and_slide()

# reset velocities
func reset_velocity(speed: float):
	characterbody.velocity.x = move_toward(characterbody.velocity.x, 0, speed)
	characterbody.velocity.y = move_toward(characterbody.velocity.y, 0, speed)
	characterbody.move_and_slide()

func reset_velocity_x(speed: float):
	characterbody.velocity.x = move_toward(characterbody.velocity.x, 0, speed)
	characterbody.move_and_slide()

func reset_velocity_y(speed: float):
	characterbody.velocity.y = move_toward(characterbody.velocity.y, 0, speed)
	characterbody.move_and_slide()

func shock():
	print("shock")
	if shocked:
		freeze = not freeze

func _ready():
	var timer = Timer.new()
	timer.wait_time = 0.3
	timer.one_shot = false
	timer.timeout.connect(shock)
	print("hmmm")
	add_child(timer)
	timer.start()
