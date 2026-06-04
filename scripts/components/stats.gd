extends Node
class_name Stats

@export_category("general")
@export var health : int
@export var max_health: int
@export var current_speed: float
@export var speed:float
@export var damage_factor: float
@export var shield_factor: float

@export_category("status effects")
@export var effect_factors: Dictionary[int, float]
@export var capacity: float
@export var cooldown_factor: float