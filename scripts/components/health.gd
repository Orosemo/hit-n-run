extends Node
class_name Health

@export var display: ProgressBar
@export var stats: Stats

signal death

func heal(amount: int):
    if stats.health + amount < stats.max_health:
        stats.health += amount
    else :
       stats.health = stats.max_health
    update_display()

func damage (amount: int):
    if stats.health - amount * stats.shield_factor  > 0:
        stats.health -= amount * stats.shield_factor
    else :
        stats.health = 0
        death.emit()
    update_display()

func get_health():
    return stats.health

func set_health(new_health: int):
    stats.health = new_health 
    update_display()

func update_display():
    if display:
        display.value = stats.health

func _ready():
    display.min_value = 0
    display.max_value = stats.max_health
    display.value = stats.max_health