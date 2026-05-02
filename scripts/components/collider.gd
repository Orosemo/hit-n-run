extends Area2D
class_name Collider

@export var health_change : int
@export var type: int
@export var max_duration:float
@export var strengh: int
@export var shape : CollisionShape2D

@export_enum("damage", "heal") var collider_type : String

func activate():
    shape.disabled = false

func deactivate():
    shape.disabled = true

func _ready():
    self.add_to_group(collider_type)