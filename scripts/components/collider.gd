extends Area2D
class_name Collider

@export var effect: StatusEffect
@export var damage: float
@export var shape : CollisionShape2D


func activate():
    shape.disabled = false

func deactivate():
    shape.disabled = true