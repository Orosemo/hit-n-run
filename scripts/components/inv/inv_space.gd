extends Container
class_name InvSpace

@export var inv_slots: Array[InvSlot]
@export var generate := false
@export var space_size : int

func _ready() -> void:
	var dir = DirAccess.open("user://")
	if dir.dir_exists("saves/") == null:
		for i in range(space_size):
			var new_slot = preload("res://scenes/prefabs/inv_slot.tscn").instantiate()
			add_child(new_slot)
