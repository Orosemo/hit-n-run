extends Container
class_name InvSpace

@export var inv_slots: Array[InvSlot]
@export var generate := false
@export var space_size : int

"""func _ready() -> void:
	if self.get_child_count() == 0 and generate:
		for i in range(space_size):
			var new_slot = preload("res://scenes/prefabs/inv_slot.tscn").instantiate()
			new_slot.generated_slot = true
			new_slot.slot.amount = 0
			new_slot.slot.item = null
			add_child(new_slot)
			print("hey2")
		print("hey")"""
