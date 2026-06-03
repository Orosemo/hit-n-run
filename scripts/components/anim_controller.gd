extends Node2D
class_name AnimController

@export var anim_nodes_array : Array[Node2D]

var anim_nodes: Dictionary[String, Node2D]

var priority : Dictionary[String, bool]

func play_all(anim_name: String, is_priority: bool = false):
	for anim_node in anim_nodes:
		if str(anim_nodes[anim_node].animation) != anim_name and not priority[anim_node]:
			anim_nodes[anim_node].play(anim_name)
			priority[anim_node] = is_priority

func play_for_one(anim_name: String, anim_node: String, is_priority: bool = false):
	if anim_nodes.has(anim_node):
		if str(anim_nodes[anim_node].animation) != anim_name and not priority[anim_node]:
			anim_nodes[anim_node].play(anim_name)
			priority[anim_node] = is_priority
	else:
		push_error("No anim node named " + anim_node)

func play_for_multiple(anim_name: String, anim_node_names: Array[String], is_priority: bool = false):
	for anim_node_name in anim_node_names:
		if anim_nodes.has(anim_node_name):
			if str(anim_nodes[anim_node_name].animation) != anim_name and not priority[anim_node_name]:
				anim_nodes[anim_node_name].play(anim_name)
				priority[anim_node_name] = is_priority
		else:
			push_error("No anim node named " + anim_node_name)

func set_direction_for_all(direction: Vector2):
	for anim_node in anim_nodes:
		anim_nodes[anim_node].scale = direction

func set_direction_for_one(direction: Vector2, anim_node: String):
	anim_nodes[anim_node].scale = direction

func set_direction_for_multiple(direction: Vector2, anim_node_names: Array[String]):
	for anim_node_name in anim_node_names:
		if anim_nodes.has(anim_node_name):
			anim_nodes[anim_node_name].scale = direction
		else:
			push_error("No anim node named " + anim_node_name)

func unset_priority():
	for anim_node in priority:
		priority[anim_node] = false

func _ready():
	for anim_node in anim_nodes_array:
		priority[anim_node.own_name] = false
		anim_nodes[anim_node.own_name] = anim_node
		anim_node.animation_finished.connect(unset_priority)


	
