extends Control
class_name InvNode

@export var inv: Dictionary[String, InvSpace]

func save():
	var inv_data = {}
	for space_id in inv:
		var space = inv[space_id]
		if space.generate:
			inv_data[space_id] = {"size": space.space_size, "Array": Array()}
		else: 
			inv_data[space_id] = Array()
		for slot_id in space.inv_slots:
			var slot = space.inv_slots[slot_id]
			if slot.amount > 0:
				var item = slot.slot.item
				var item_data = {
					"amount": slot.slot.amount,
					"item": item.resource_path
				}
				inv_data[space_id]["Array"].insert(slot_id, item_data)
				return inv_data
				
func load(inv_data: Dictionary):
	for space_id in inv_data:
		if inv.has(space_id):
			var space = inv[space_id]
			if space.generate == true:
				for i in range(inv_data[space_id]["size"]):
					# create new slot
					var slot_node = InvSlot.new()
					var slot_data = inv_data[space_id]["Array"][i]
					slot_node.amount = slot_data.amount

					# create new item
					var item_data = slot_data["item"]
					var slot_res = Slot.new()
					slot_res.amount = item_data["amount"]
					slot_res.item = load(item_data["item"])
					slot_node.slot = slot_res
					

					# add slot
					space.add_child(slot_node)
					space.inv_slots.insert(i, slot_node)
			else:
				for slot_id in inv_data[space_id]:
					var slot = inv[space_id].inv_slots[slot_id]
					
					var slot_data = inv_data[space_id][slot_id]
					slot.amount = slot_data["amount"]

					slot.item = load(slot_data["item"])

		else:
			push_error("space" + space_id + "not available")
