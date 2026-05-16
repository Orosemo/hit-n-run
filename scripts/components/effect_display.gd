extends Control

@export var effect: StatusEffect


func update():
	$ProgressBar.value = effect.amount
	if effect.active:
		pass


func _ready() -> void:
	$Sprite2D.texture = load(effect.sprite)
	$ProgressBar.max_value = effect.capacity
	$ProgressBar.value = effect.amount
