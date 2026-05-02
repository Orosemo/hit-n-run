extends Area2D
class_name Hurtbox

@export var health_component : Health
@export var shape: CollisionShape2D
@export var effect: StatusEffects
@export var cooldown_time := 1.5

var cooldown_timer : Timer

func collision(collider):
	var change = collider.health_change
	if change: 
		if collider.is_in_group("damage"): 
			health_component.damage(change)
		elif collider.is_in_group("heal"):
			health_component.heal(change)
	if effect:
		effect.set_effect(collider.type, collider.max_duration, collider.strengh)
	
	make_invincible()
	cooldown_timer.start()
	

func make_invincible():
	shape.disabled = true

func make_vincible():
	shape.disabled = false


func _ready():
	self.area_entered.connect(collision)
	# init cooldown timer
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(make_vincible)
	add_child(cooldown_timer) 
