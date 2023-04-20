extends BaseState


export var max_time: float

var timer: float = 0


func enter(msg: Dictionary = {}) -> void:
	.enter()

	if not max_time:
		timer = character.animations.get_animation("Death").length
	else:
		timer = max_time

	print(timer)



func process(delta: float) -> BaseState:
	timer -= delta

	if timer > 0:
		return null

	get_tree().reload_current_scene()

	return null
