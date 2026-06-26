extends CanvasLayer


@onready var hud: MarginContainer = $hud
@onready var inv: InvNode = $inv
@onready var menu: Control = $menu
@onready var ui_anim: AnimationPlayer = $ui_anim

func _ready() -> void:
	inv.visible = false
	menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if inv.visible:
			TimeManager.play()
			ui_anim.play("inv_exit")
		else:
			TimeManager.pause()
			ui_anim.play("inv_entry")

	if Input.is_action_just_pressed("back") and inv.visible:
		TimeManager.play()
		ui_anim.play("inv_exit")

	if Input.is_action_just_pressed("escape"):
		if menu.visible:
			TimeManager.play()
			ui_anim.play("menu_exit")
		else:
			TimeManager.pause()
			ui_anim.play("menu_entry")
			$menu/VBoxContainer/continoue.grab_focus()

	if Input.is_action_just_pressed("back") and menu.visible:
		TimeManager.play()
		ui_anim.play("menu_exit")

func _on_continoue_pressed() -> void:
	TimeManager.play()
	ui_anim.play("menu_exit")


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_save_pressed() -> void:
	SaveManager.save()


func _on_exit_pressed() -> void:
	pass # Replace with function body.
