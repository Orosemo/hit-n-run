extends CanvasLayer


@onready var hud: MarginContainer = $hud
@onready var inv: InvNode = $inv
@onready var menu: Control = $menu
@onready var ui_anim: AnimationPlayer = $ui_anim
@onready var continoue: Button = $menu/VBoxContainer/continoue
@onready var inv_blend: ColorRect = $inv_blend
@onready var menu_blend: ColorRect = $menu_blend


func _ready() -> void:
	inv.visible = false
	menu.visible = false
	inv_blend.color = Color(0 ,0 ,0 ,0)
	menu_blend.color = Color(0 ,0 ,0 ,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if inv.visible:
			TimeManager.play()
			inv.save_state()
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
			continoue.grab_focus()

	if Input.is_action_just_pressed("back") and menu.visible:
		TimeManager.play()
		ui_anim.play("menu_exit")

func _on_continoue_pressed() -> void:
	TimeManager.play()
	ui_anim.play("menu_exit")


func _on_settings_pressed() -> void:
	SaveManager.load_save()


func _on_save_pressed() -> void:
	SaveManager.save()


func _on_exit_pressed() -> void:
	pass # Replace with function body.


func _on_ui_anim_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		
		"menu_entry":
			continoue.grab_focus()

		"inv_entry":
			inv.load_state()
