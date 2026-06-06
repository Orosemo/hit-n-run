extends Resource
class_name CurrentEffects

@export var current_status_effects: Dictionary[int, StatusEffect]

func add_new_effect(new_effect: StatusEffect, capacity: float):
	var id = new_effect.id
	if check_if_status_effect(id):
		var current_status_effect = current_status_effects[id]
		current_status_effect.capacity = capacity
		current_status_effect.strenght = new_effect.strenght

		if not current_status_effect.active:
			if current_status_effect.amount + new_effect.amount > current_status_effect.capacity:
				current_status_effect.amount = current_status_effect.capacity
				current_status_effect.active = true
			else: 
				current_status_effect.amount += new_effect.amount
				current_status_effect.active = false

	else:
		new_effect.capacity = capacity
		current_status_effects[id] = new_effect
	return current_status_effects

func remove_existing_effect(id: int):
	if check_if_status_effect(id):
		current_status_effects.erase(id)
	return current_status_effects

func check_if_status_effect(id: int):
	return current_status_effects.has(id)
