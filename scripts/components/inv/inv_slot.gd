extends Control
class_name InvSlot

@export var amount: int
@export var item: Item

@onready var bg: InvSlot = $"."
@onready var tooltip: TextureRect = $tooltip
@onready var rarity: TextureRect = $rarity
@onready var item_texture: TextureRect = $item
@onready var label: Label = $Label

func populate():
	if item != null:
		tooltip.visible = false
	else:
		tooltip.visible = true
	item_texture.texture = load(item.icon)
	rarity.texture = load(GlobalAssets.rarities[item.rarity])
	label.text = str(amount)

func _ready() -> void:
	populate()
