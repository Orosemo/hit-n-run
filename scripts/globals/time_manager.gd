extends Node

func unfreeze_frame():
    get_tree().paused = false

func freeze_frame(duration: float):
    get_tree().paused = true
    var timer = Timer.new()
    timer.one_shot = true
    timer.wait_time = duration
    timer.timeout.connect(unfreeze_frame())
    add_child(timer)
    timer.start()


func pause():
    get_tree().paused = true

func play():
    get_tree().paused = false