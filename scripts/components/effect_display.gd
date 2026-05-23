extends Control

@export var effect: StatusEffect


func update():
	$ProgressBar.value = effect.amount
	if effect.active:
		pass


func _ready() -> void:
	$ProgressBar.max_value = effect.capacity
	$ProgressBar.value = effect.amount
	if effect.active:
		$ProgressBar.texture_under = load(effect.assets[effect.id]["active_empty"])
		$ProgressBar.texture_progress = load(effect.assets[effect.id]["active_full"])
	else:
		$ProgressBar.texture_under = load(effect.assets[effect.id]["empty"])
		$ProgressBar.texture_progress = load(effect.assets[effect.id]["full"])
