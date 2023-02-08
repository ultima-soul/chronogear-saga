extends BaseState

export var move_speed: float = 60
export var jump_init_speed: float = 135

func enter() -> void:
	player.velocity.y = -jump_init_speed

func physics_process(delta: float) -> int:
	var move_dir: int = 0

	if Input.is_action_pressed("move_left"):
		move_dir = -1
	elif Input.is_action_pressed("move_right"):
		move_dir = 1

	player.velocity.y += player.gravity
	player.velocity.x = move_dir * move_speed
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.is_on_floor():
		if move_dir != 0:
			return State.WALK
		else:
			return State.IDLE

	return State.NULL
