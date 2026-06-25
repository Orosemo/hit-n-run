extends Resource
class_name Item

@export var name: String
@export var icon: Texture2D
@export var function: String
@export_enum("common", "uncommon", "rare", "superrare", "mythical", "legendary") var rarity
@export_enum("consumable", "weapon", "usable", "misc") var type