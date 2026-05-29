extends Area2D
class_name Collider

@export var effect: StatusEffect
@export var damage: float
@export var shape : CollisionShape2D


func activate():
    shape.set_deferred("disabled", false)

func deactivate():
    shape.set_deferred("disabled", true)