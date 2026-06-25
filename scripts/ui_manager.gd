extends CanvasLayer


@onready var hud: MarginContainer = $hud
@onready var inv: InvNode = $inv
@onready var menu: Control = $menu


func _ready() -> void:
	inv.visible = false
	menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if inv.visible:
			TimeManager.play()
		else:
			TimeManager.pause()
		inv.visible = !inv.visible

	if Input.is_action_just_pressed("escape"):
		menu.visible = !menu.visible
