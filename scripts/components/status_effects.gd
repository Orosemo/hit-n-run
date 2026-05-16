extends Node
class_name StatusEffects

@onready var effect_display_scene = load("res://scenes/components/effect_display.tscn")

@export_category("needed components")
@export var health_component: Health
@export var velocity: Velocity
@export var container: Container

@export_category("misc")
@export var current_effects: CurrentEffects
@export var effect_factors: Dictionary[int, float]
@export var capacity: float
@export var cooldown_factor: float

var tick_timer

func add_effect(effect: StatusEffect):
	current_effects.add_new_effect(effect, capacity)

func execute_effects(effect):
	# reset effects
	velocity.shock = false

	# execute effects
	match effect.id:
		GlobalVars.FIRE:
			health_component.damage(effect.strengh)
		GlobalVars.POISON:
			if health_component.get_health() - effect.strengh > 0:
				health_component.damage(effect.strengh)
			else:
				health_component.set_health(effect.strengh)
		GlobalVars.DEATH:
			health_component.damage(effect.strengh)
		GlobalVars.REGENERATION:
			health_component.heal(effect.strengh)
		GlobalVars.SHOCK:
			velocity.shock = true

func update_effects():
	for effect_id in current_effects.current_status_effects:
		if current_effects.check_if_status_effect(effect_id):
			var effect = current_effects.current_status_effects[effect_id]
			var decrement := 1.0
			if effect_factors and effect_factors.has(effect_id):
				decrement *= effect_factors[effect_id]
			if effect.active:
				decrement *= cooldown_factor

			if effect.amount - decrement > 0:
				effect.amount -= decrement
			else:
				effect.amount = 0
				current_effects.remove_existing_effect(effect.id)
		print(effect_id)

	render_effects()


func render_effects():
	clear_container_children()
	if container:
		for effect in current_effects.current_status_effects:
			var new_effect_display = effect_display_scene.instantiate()
			new_effect_display.effect = current_effects.current_status_effects[effect]
			container.add_child(new_effect_display)

func clear_container_children():
	if container:
		for child in container.get_children():
			child.queue_free()

func _ready():
	tick_timer = Timer.new()
	tick_timer.wait_time = GlobalVars.effect_tick
	tick_timer.one_shot = false
	tick_timer.timeout.connect(update_effects)
	add_child(tick_timer)
	tick_timer.start()
