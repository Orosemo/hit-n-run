extends Node
class_name InventoryNode

@export var inventory_res: Inventory
@export var spaces: Dictionary[String, Container]

func load_inv(inv_dic: Dictionary):
    for space_name in inv_dic:
        var inv_space = InventorySpace.new()
        


# {name:  [slot1{"item":"path", "amount":"1"}, slot2{"item":"path", "amount":"3"},]}

"""  for space_name in inv_dic:
        if spaces.has(space_name):
            var space = spaces[space_name]
            if spaces[space_name].slot_nodes.length > 0:
                for slot_id in space:
                    spaces[space_name].slot_nodes[slot_id].item = space[slot_id]["item"]
                    spaces[space_name].slot_nodes[slot_id].amout = int(space[slot_id]["amount"])
            else:
                var """