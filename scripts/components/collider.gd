extends Area2D
class_name Collider

@export var health_change : int
@export var shape : CollisionShape2D

@export_enum("damage", "heal") var type : String

func activate():
    shape.disabled = false

func deactivate():
    shape.disabled = true

func _ready():
    self.add_to_group(type)