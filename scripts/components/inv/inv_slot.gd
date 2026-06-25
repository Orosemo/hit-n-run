extends Control
class_name InvSlot

@export var amount: int
@export var item: Item
@export var equipment: bool

@onready var bg: InvSlot = $"."
@onready var rarity: TextureRect = $rarity
@onready var item_texture: TextureRect = $item
@onready var tooltip: TextureRect = $tooltip
@onready var label: Label = $Label

signal item_changed

func _get_drag_data(at_position: Vector2) -> Variant:
	if !item or item == null:
		return
	 
	var preview = Control.new()
	preview.add_child(rarity.duplicate())
	preview.add_child(item_texture.duplicate())
	preview.add_child(label.duplicate())
	preview.position -= Vector2(25, 25)
	preview.self_modulate = Color(preview.modulate, 0.5)

	set_drag_preview(preview)
	return {"item": item, "amount": amount}

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if !item or item == null:
		amount = data["amount"]
		item = data["item"]
		data = null
	else:
		var new_data = data
		data = {"item": item, "amount": amount}
		amount = new_data["amount"]
		item = new_data["item"]
	

func populate():
	if item != null:
		tooltip.visible = false
		item_changed.emit(item, amount)
		item_texture.texture = item.icon
		rarity.texture = load(GlobalAssets.rarities[item.rarity])
		if not equipment:
			label.text = str(amount)
	else:
		tooltip.visible = true
		item_changed.emit(false)

func _ready() -> void:
	populate()
	
func _process(delta: float) -> void:
	populate()