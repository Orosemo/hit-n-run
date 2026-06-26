extends Node

func save():
    if GlobalVars.save_slot:
        var save_file = FileAccess.open("user://savegame'%s'.save" % GlobalVars.save_slot, FileAccess.WRITE)
        var save_nodes = get_tree().get_nodes_in_group("Persist")
        for node in save_nodes:
            if node.scene_file_path.is_empty():
                print("persistent node '%s' is not an instanced scene, skipped" % node.name)
                continue

            if !node.has_method("save"):
                print("persistent node '%s' is missing a save() function, skipped" % node.name)
                continue

            var node_data = node.call("save")

            var json_string = JSON.stringify(node_data)

            save_file.store_line(json_string)

func load():
    if GlobalVars.save_slot:
        if not FileAccess.file_exists("user://savegame.save"):
            return

        var save_nodes = get_tree().get_nodes_in_group("Persist")
        for node in save_nodes:
            node.queue_free()

        var save_file = FileAccess.open("user://savegame'%s'.save" % GlobalVars.save_slot, FileAccess.READ)

        while save_file.get_position() < save_file.get_length():
            var json_string = save_file.get_line()

            var json = JSON.new()

            var parse_result = json.parse(json_string)

            if not parse_result == OK:
                continue

            var node_data = json.data

            var new_object = load(node_data["filename"]).instantiate()
            get_node(node_data["parent"]).add_child(new_object)
            new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
            
            new_object.load_data(node_data)