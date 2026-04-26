extends Node
class_name Velocity

@export var characterbody: CharacterBody2D

# set velocities
func set_velocity(direction: Vector2):
	characterbody.velocity.x = direction.x
	characterbody.velocity.y = direction.y
	characterbody.move_and_slide()

func set_velocity_x(speed: float):
	characterbody.velocity.x = speed
	characterbody.move_and_slide()

func set_velocity_y(speed: float):
	characterbody.velocity.y = speed
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
