class_name AIInputState
extends BaseState


func _on_Timer_timeout() -> void:
	character.move_dir = randi() % 3 - 1


func _ready() -> void:
	randomize()


func enter(msg: Dictionary = {}) -> void:
	.enter()
	character.timer.start(4)
