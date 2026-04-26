extends Area2D
class_name Hurtbox

@export var health_component : Health

func collision(collider):
	if collider.damage:
		health_component.damage(collider.damage)

func _ready():
	self.area_entered.connect(collision)
