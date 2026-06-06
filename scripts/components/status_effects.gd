extends Node
class_name StatusEffects

@onready var effect_display_scene = load("res://scenes/components/effect_display.tscn")

@export_category("needed components")
@export var health_component: Health
@export var velocity: Velocity
@export var container: Container
@export var stats: Stats
@export var effect_particles: EffectParticles

@export_category("misc")
@export var current_effects: CurrentEffects

var tick_timer
var current_status_effects_delta: Dictionary

func add_effect(effect: StatusEffect):
	current_effects.add_new_effect(effect, stats.capacity)

func update_effects():
	for effect_id in current_effects.current_status_effects:
		if current_effects.check_if_status_effect(effect_id):
			var effect = current_effects.current_status_effects[effect_id]
			var decrement := 1.0
			if stats.effect_factors and stats.effect_factors.has(effect_id):
				decrement *= stats.effect_factors[effect_id]
			if effect.active:
				decrement *= stats.cooldown_factor

			if effect.amount - decrement > 0:
				effect.amount -= decrement
			else:
				effect.amount = 0
				current_effects.remove_existing_effect(effect.id)

	render_effects()
	effect_particles.draw_effects(current_effects.current_status_effects)
	execute_effects()
 
func execute_effects():
	if current_status_effects_delta.size() == 0 and not current_effects.current_status_effects.size() == 0:
		current_status_effects_delta = current_effects.current_status_effects

	for effect in current_effects.current_status_effects:
		var status_effect = current_effects.current_status_effects[effect]
		var delta_status_effect =  current_status_effects_delta[effect]
		if current_status_effects_delta.has(effect):
			if status_effect.active:
				print("effect executed")
				match current_effects.current_status_effects[effect].id:
					0: # poison
						if not status_effect.executed:
							stats.speed *= status_effect.strenght
							status_effect.executed = true
					1: # shock
						if not status_effect.executed:
							velocity.shocked = true
							status_effect.executed = true
					2: # frost
						if not status_effect.executed:
							stats.speed *= status_effect.strenght
							stats.shield_factor *= status_effect.strenght
							status_effect.executed = true
					3: # death
						if not stats.health * status_effect.strenght > 5:
							stats.health *= status_effect.strenght
						else:
							stats.health = 5
					4: # fire
						stats.health -= status_effect.strenght
					5: # regeneration
						stats.health += status_effect.strenght
					6: # sleep
						if not status_effect.executed:
							stats.speed *= status_effect.strenght
							status_effect.executed = true
					7: # confusion
						if not status_effect.executed:
							velocity.confused = true
							status_effect.executed = true
					8: # slowness
						if not status_effect.executed:
							stats.speed *= status_effect.strenght
							status_effect.executed = true
					9: # speed
						if not status_effect.executed:
							stats.speed *= status_effect.strenght
							status_effect.executed = true
					10: # weakness
						if not status_effect.executed:
							stats.damage_factor *= status_effect.strenght
							status_effect.executed = true
					11: # strength
						if not status_effect.executed:
							stats.damage_factor -= 1 * status_effect.strenght
							status_effect.executed = true

		# remove effect executions
		else:
			if delta_status_effect.active:
				print("not executed")
				match current_status_effects_delta[effect].id:
					0: # poison
						if delta_status_effect.executed:
							stats.speed /= delta_status_effect.strenght
					1: # shock
						if delta_status_effect.executed:
							velocity.shocked = false
					2: # frost
						if delta_status_effect.executed:
							stats.speed /= delta_status_effect.strenght
							stats.shield_factor /= delta_status_effect.strenght
					3: # death
						pass
					4: # fire
						pass
					5: # regeneration
						stats.health += delta_status_effect.strenght
					6: # sleep
						if delta_status_effect.executed:
							stats.speed /= delta_status_effect.strenght
					7: # confusion
						if delta_status_effect.executed:
							velocity.confused = false
					8: # slowness
						if delta_status_effect.executed:
							stats.speed -= 1 / delta_status_effect.strenght
					9: # speed
						if delta_status_effect.executed:
							stats.speed -= 1 / delta_status_effect.strenght
					10: # weakness
						if delta_status_effect.executed:
							stats.damage_factor -= 1 / delta_status_effect.strenght
					11: # strength
						if delta_status_effect.executed:
							stats.damage_factor -= 1 / delta_status_effect.strenght
		
		health_component.update_display()

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
