extends Resource
class_name Inventory

@export var inventory: Dictionary[String, InventorySpace]

func get_slot(space:String, id:int):
    return inventory[space][id]

func set_slot(space:String, id:int, item:Item, amount:int):
    inventory[space][id].set_item(item, amount)

func reset_slot(space:String, id:int):
    inventory[space][id].clear_item()
