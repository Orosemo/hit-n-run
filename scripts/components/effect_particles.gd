extends Node2D
class_name EffectParticles

@export var emitter_template: CPUParticles2D
@export var emitter_container: Node2D

var effect_emitters : Dictionary[int, CPUParticles2D] = {}

func draw_emitter(effect: StatusEffect):
	if not effect_emitters.has(effect.id):
		var new_emitter = emitter_template.duplicate()
		new_emitter.texture = load(GlobalAssets.status_effect_anims_assets[effect.id])
		emitter_container.add_child(new_emitter)
		new_emitter.emitting = true
		effect_emitters[effect.id] = new_emitter

func draw_effects(effects: Dictionary):
	for effect_id in effects:
		var effect = effects[effect_id]
		if effect_emitters.has(effect.id):
			pass
		else:
			if effect.active:
				draw_emitter(effect)
