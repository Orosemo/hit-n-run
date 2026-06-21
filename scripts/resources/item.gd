extends Resource
class_name Item

@export var name: String
@export var icon: String
@export var function: String
@export_enum("consumable", "weapon", "usable", "misc") var type