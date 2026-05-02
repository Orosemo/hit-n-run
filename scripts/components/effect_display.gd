extends ProgressBar

@export var sprite: AtlasTexture
@export var remaining_duration: float
@export var duration: float
@export var type: int


func update(new_remaining_duration, new_duration = null):
	$ProgressBar.value = new_remaining_duration
	if not new_duration == null:
		$ProgressBar.value = new_remaining_duration


func _ready() -> void:
	$Sprite2D.texture = sprite
	$ProgressBar.max_value = duration
	$ProgressBar.value = remaining_duration
