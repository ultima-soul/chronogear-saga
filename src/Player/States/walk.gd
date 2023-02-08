extends BaseState

var move_speed: int = 60

func input(event: InputEvent) -> int:
	return State.NULL


func physics_process(delta: float) -> int:
	var move_dir: int = 0

	if Input.is_action_pressed("move_left"):
		move_dir = -1
	elif Input.is_action_pressed("move_right"):
		move_dir = 1

	player.velocity.y += player.gravity
	player.velocity.x = move_dir * move_speed
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if move_dir == 0:
		return State.IDLE

	return State.NULL
