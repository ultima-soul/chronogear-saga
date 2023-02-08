extends BaseState


func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return State.WALK
	elif Input.is_action_just_pressed("jump"):
		return State.JUMP

	return State.NULL


func physics_process(delta: float) -> int:
	player.velocity.y += player.gravity
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	return State.NULL
