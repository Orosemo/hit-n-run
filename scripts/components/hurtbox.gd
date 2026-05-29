extends Area2D
class_name Hurtbox

@export var health_component : Health
@export var shape: CollisionShape2D
@export var effects: StatusEffects
@export var cooldown_time := 1.5

var cooldown_timer : Timer

func collision(collider):
	health_component.damage(collider.damage)
	if collider.effect:
		effects.add_effect(collider.effect.duplicate())
	
	collider.deactivate()
	cooldown_timer.start()
	

func make_invincible():
	shape.set_deferred("disabled", true)

func make_vincible():
	shape.set_deferred("disabled", false)


func _ready():
	self.area_entered.connect(collision)
	# init cooldown timer
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(make_vincible)
	add_child(cooldown_timer) 
