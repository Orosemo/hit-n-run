extends Resource
class_name Slot

@export var item: Item 
@export var amount: int 

func clear_item():
    item = null 
    amount = 0

func set_item(new_item: Item, new_amount:int):
    item = new_item
    amount = new_amount