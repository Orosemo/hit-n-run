extends Node2D
class_name AnimController

@export var anims_nodes: Dictionary[String, Node2D]

func play_all(anim_name: String):
	for anim_node in anims_nodes:
		if not anims_nodes[anim_node].animation == anim_name:
			anims_nodes[anim_node].play(anim_name)

func play_for_one(anim_name: String, anim_node: String):
	if anims_nodes.has(anim_node):
		if not anims_nodes[anim_node].animation == anim_name:
			anims_nodes[anim_node].play(anim_name)
	else:
		push_error("No anim node named " + anim_node)

func play_for_multiple(anim_name: String, anim_node_names: Array[String]):
	for anim_node_name in anim_node_names:
		if anims_nodes.has(anim_node_name):
			if not anims_nodes[anim_node_name].animation == anim_name:
				anims_nodes[anim_node_name].play(anim_name)
		else:
			push_error("No anim node named " + anim_node_name)

func set_direction_for_all(direction: Vector2):
	for anim_node in anims_nodes:
		anims_nodes[anim_node].scale = direction

func set_direction_for_one(direction: Vector2, anim_node: String):
	anims_nodes[anim_node].scale = direction
	push_error("No anim node named " + anim_node)

func set_direction_for_multiple(direction: Vector2, anim_node_names: Array[String]):
	for anim_node_name in anim_node_names:
		if anims_nodes.has(anim_node_name):
			anims_nodes[anim_node_name].scale = direction
		else:
			push_error("No anim node named " + anim_node_name)
