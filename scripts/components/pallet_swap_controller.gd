extends Node
class_name PalletSwapController

@export var nodes_array : Array[Node2D]
@export var pallets: Dictionary[String, AtlasTexture]

var nodes: Dictionary[String, Node2D]

func set_pallet_all(pallet_name: String):
	for node in nodes:
		var mat := nodes[node].material as PaletteMaterial
		if not mat.palette == pallets[pallet_name] or mat.palette == null:
			mat.palette = pallets[pallet_name]

func set_pallet_for_one(pallet_name: String, node: String,):
	if nodes.has(node):
		var mat := nodes[node].material as PaletteMaterial
		if not mat.palette == pallets[pallet_name] or mat.palette == null:
			mat.palette = pallets[pallet_name]
	else:
		push_error("No anim node named " + node)

func set_pallet_for_multiple(pallet_name: String, node_names: Array[String],):
	for node_name in node_names:
		if nodes.has(node_name):
			var mat := nodes[node_name].material as PaletteMaterial
			if not mat.palette == pallets[pallet_name] or mat.palette == null:
				mat.palette = pallets[pallet_name]
		else:
			push_error("No anim node named " + node_name)

func _ready():
	for node in nodes_array:
		nodes[node.own_name] = node
