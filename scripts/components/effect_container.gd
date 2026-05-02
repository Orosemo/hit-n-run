extends GridContainer
class_name EffectContainer

var effect_displays : Array[NodePath]

@onready var effect_display_scene = load("res://scenes/components/effect_display.tscn")

func manage_effect(type: int, duration: float, current_duration: float):
	for effect_node_path in effect_displays:
		var effect_display = get_node(effect_node_path)
		if effect_display.type == type:
			if current_duration == 0:
				effect_display.queue_free()
				effect_displays.erase(effect_node_path)
			else:
				effect_display.update(current_duration, duration)
		else:
			var new_effect_display = effect_display_scene.new()
			new_effect_display.type = type
			new_effect_display.sprite = load(GlobalVars.effects_sprites[type])
			new_effect_display.remaining_duration = current_duration
			new_effect_display.duration = duration
			effect_displays.append(new_effect_display.NodePath)
			add_child(new_effect_display)
