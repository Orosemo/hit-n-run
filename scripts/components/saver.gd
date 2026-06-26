extends Node
class_name Saver

@export var root: Node2D
@export var stats: Stats
@export var inv: InvNode

func save():
    print('save')
    var save_data = {}
    if inv:
        save_data = {
            "filename" : root.get_scene_file_path(),
            "parent" : root.get_parent().get_path(),
            "pos_x" : root.position.x,
            "pos_y" : root.position.y,
            "stats": {
                "health": stats.health,
                "max_health": stats.max_health,
                "current_speed": stats.current_speed,
                "speed":stats.speed,
                "damage_factor": stats.damage_factor,
                "shield_factor": stats.shield_factor,
                "jump_velo": stats.jump_velo,
                "effect_factors": stats.effect_factors,
                "capacity": stats.capacity,
                "cooldown_factor": stats.cooldown_factor,            
            },
            "inv": inv.save(),
        }
    elif not inv:
        save_data = {
            "filename" : root.get_scene_file_path(),
            "parent" : root.get_parent().get_path(),
            "pos_x" : root.position.x,
            "pos_y" : root.position.y,
            "stats": {
                "health": stats.health,
                "max_health": stats.max_health,
                "current_speed": stats.current_speed,
                "speed":stats.speed,
                "damage_factor": stats.damage_factor,
                "shield_factor": stats.shield_factor,
                "jump_velo": stats.jump_velo,
                "effect_factors": stats.effect_factors,
                "capacity": stats.capacity,
                "cooldown_factor": stats.cooldown_factor,            
            },
        }
    return save_data

func load_data(save_data):
    if inv:
        inv.load(save_data["inv"])
    for key in save_data["stats"].keys():
        stats.set(key, save_data["stats"][key])