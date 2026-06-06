extends Node2D
class_name EffectParticles

@export var emitter_template: CPUParticles2D
@export var emitter_container: Node2D

var effect_emitters : Array[CPUParticles2D] = []

func draw_emitter(effect: StatusEffect):
	var new_emitter = emitter_template.duplicate()
	new_emitter.texture = load(GlobalAssets.status_effect_anims_assets[effect.id])
	emitter_container.add_child(new_emitter)
	new_emitter.emitting = true
	if effect_emitters.size() <= effect.id:
		effect_emitters.resize(effect.id + 1)
	effect_emitters.insert(effect.id, new_emitter)

func draw_effects(effects: Dictionary):
	clear_container_children()
	effect_emitters = []
	for effect_key in effects:
		var effect = effects[effect_key]
		if effect.active:
			draw_emitter(effect)
		
func clear_container_children():
	if emitter_container:
		for child in emitter_container.get_children():
			child.queue_free()
