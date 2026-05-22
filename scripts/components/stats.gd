extends Node
class_name Stats

@export_category("general")
@export var health : int
@export var max_health: int

@export_category("status effects")
@export var effect_factors: Dictionary[int, float]
@export var capacity: float
@export var cooldown_factor: float