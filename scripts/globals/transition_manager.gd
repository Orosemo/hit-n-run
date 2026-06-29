extends ColorRect

var scene_path: String
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func transition(path: String):
	print("transition")
	animation_player.play("transition")
	scene_path = path

# Called every frame. 'delta' is the elapsed time since the previous frame.
func switch():
	get_tree().change_scene_to_file(scene_path)
