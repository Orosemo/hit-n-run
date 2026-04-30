extends Area2D
class_name Hurtbox

@export var health_component : Health
@export var shape: CollisionShape2D

func collision(collider):
	var change = collider.health_change
	if change: 
		if collider.is_in_group("damage"): 
			health_component.damage(change)
		elif collider.is_in_group("heal"):
			health_component.heal(change)

func make_invincible():
	shape.disabled = true

func make_vincible():
	shape.disabled = false


func _ready():
	self.area_entered.connect(collision)
