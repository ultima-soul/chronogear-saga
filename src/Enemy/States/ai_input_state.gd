class_name AIInputState
extends BaseState

var curr_state_timer: SceneTreeTimer

#func physics_process(delta: float) -> BaseState:

func enter() -> void:
	curr_state_timer = get_tree().create_timer(4)

func get_move_dir() -> int:
	if curr_state_timer.time_left <= 0:
		character.move_dir = randi() % 3 - 1

	print(character.move_dir)
	return character.move_dir;
