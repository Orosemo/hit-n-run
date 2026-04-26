extends Node
class_name Health

@export var display: ProgressBar
@export var health : int
@export var max_health: int

func heal(amount: int):
    if health + amount < max_health:
        health += amount
    else :
        health = max_health
    update_display()

func damage (amount: int):
    if health - amount > 0:
        health -= amount
    else :
        health = 0
    update_display()

func update_display():
    if display:
        display.value = health