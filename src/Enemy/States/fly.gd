extends AIInputState


export var move_speed: float = 60


func physics_process(delta: float) -> BaseState:
	var move_dir: int = character.move_dir

	character.velocity.x = move_dir * move_speed / (2 if character.slowdown_enabled else 1)
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	return null
