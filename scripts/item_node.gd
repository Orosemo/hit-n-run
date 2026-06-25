extends RigidBody2D

@onready var bg: Sprite2D = $bg
@onready var item_node: Sprite2D = $item
@onready var light: PointLight2D = $light

@export var item: Item

func update():
	bg.texture = load(GlobalAssets.rarities[item.rarity])
	item_node.texture = item.icon
	light.color = Color(229, 28, 35, 255)

func _ready() -> void:
	if item:
		update()
