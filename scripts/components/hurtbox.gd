extends Area2D
class_name Hurtbox

func collision(collider):
    pass

func _ready():
    self.area_entered.connect(collision)
